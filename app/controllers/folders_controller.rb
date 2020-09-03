class FoldersController < ApplicationController
   
    include ActionController::Live
    include ZipTricks::RailsStreaming

    def index 
        @folders = Folder.roots
    end
      
    def show 
        @folder = Folder.find(params[:id]) 
        @sub_folders = @folder.children
        @photos = @folder.photos
    end
   
    def new
        @folder = Folder.new
     end

    def create 
        @folder = Folder.new(folder_params)
        if @folder.save 
         flash[:notice] = "Successfully created folder."
           
         if @folder.parent #checking if we have a parent folder on this one 
           redirect_to @folder.parent  #then we redirect to the parent folder 
         else
           redirect_to @folder #if not, redirect back to home page 
         end
        else
         render :action => 'new'
        end
     end
      
    def edit 
        @folder = Folder.find(params[:id]) 
    end
      
    def update 
        @folder = Folder.find(params[:id]) 
        @folder.update(folder_params)
        if @folder.parent #checking if we have a parent folder on this one 
          redirect_to folder_path(@folder.parent) #then we redirect to the parent folder 
        else
          redirect_to folder_path(@folder) #if not, redirect back to home page 
        end
    end

    def add_files
      uploaded_filenames = []
      params[:photos].each do |file|
        uploaded_filenames << file.original_filename
      end
      if (uploaded_filenames & ActiveStorage::Blob.distinct.pluck(:filename)).length > 100
          flash.now[:alert] = "The file(s) #{(uploaded_filenames & ActiveStorage::Blob.distinct.pluck(:filename)).join(", ")} already exist. Please only upload new files"
          render "uploads/show", folder_id: params[:folder_id]
      else 
        @folder = Folder.find(params[:folder_id]) 
        @folder.photos.attach(params[:photos])     
        @folder.permissions.attach(params[:permissions])
        @folder.photos.blobs.where(filename: uploaded_filenames).each do |blob|
          blob.update(photographer_id: params[:photographer_id])
          params[:photo][:tag_ids].each do |tag|
            Tagging.create(tag_id: tag, blob_id: blob.id)
          end
        end
        redirect_to "/"
      end
    end

    def destroy 
        @folder = Folder.find(params[:id])
        @folder.destroy
        if @folder.parent #checking if we have a parent folder on this one 
          redirect_to folder_path(@folder.parent) #then we redirect to the parent folder 
        else
          redirect_to '/' #if not, redirect back to home page 
        end
    end

    def browse 
        #get the folders owned/created by the current_user 
        @current_folder = Folder.find(params[:folder_id])   
      
        if @current_folder
        
          #getting the folders which are inside this @current_folder 
          @folders = @current_folder.children 
          
          render :action => "index"
        end
    end
    
    private

    def folder_params
        params.require(:folder).permit(:name, :parent_id)
    end

end

