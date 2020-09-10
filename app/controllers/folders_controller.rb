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
            if params[:folder][:index_referrer]  #checking if the request comes from the index pages 
              redirect_to action: "index"
            elsif @folder.parent #checking if we have a parent folder on this one 
                redirect_to @folder.parent  #then we redirect to the parent folder 
            else
              redirect_to @folder #if not, redirect back to the folder that just has been created
            end
        else
          flash[:alert] = "Folder could not be created" 
          render :action => 'new'
        end
    end
      
    def edit 
        @folder = Folder.find(params[:id]) 
    end
      
    def update 
        @folder = Folder.find(params[:id]) 
        @folder.update(folder_params)
        if params[:folder][:index_referrer] #checking if the request comes from the index pages 
          redirect_to action: "index"
        elsif @folder.parent #checking if we have a parent folder on this one 
            redirect_to @folder.parent  #then we redirect to the parent folder 
        else
          redirect_to @folder #if not, redirect back to the folder that just has been created
        end
    end

    def add_files
      uploaded_photonames = []
      params[:photos].each do |file|
        uploaded_photonames << file.original_filename
      end
      uploaded_permissionnames = []
      params[:permissions].each do |file|
        uploaded_permissionnames << file.original_filename
      end
      if (uploaded_photonames & ActiveStorage::Blob.distinct.pluck(:filename)).length > 0
          flash.now[:alert] = "The file(s) #{(uploaded_photonames & ActiveStorage::Blob.distinct.pluck(:filename)).join(", ")} already exist. Please only upload new files"
          render "uploads/show", folder_id: params[:folder_id]
      else 
        @folder = Folder.find(params[:folder_id]) 
        @folder.photos.attach(params[:photos])     
        @folder.permissions.attach(params[:permissions])
        @folder.photos.blobs.where(filename: uploaded_photonames).each do |blob|
          blob.update(photographer_id: params[:photographer_id], shooting_date: params[:shooting_date])
          blob.update(deletion_date: (blob.shooting_date + 1.year))
          blob.tags << Tag.where(id: params[:photo][:tag_ids].reject {|k| k == ""})
            @folder.permissions.last(uploaded_permissionnames.length).each do |permission|
                Permission.create(attachment_id: permission.id, blob_id: blob.id).errors.full_messages
            end
          end
        redirect_to folder_path(@folder)
      end
    end

    def delete_attachment
      ActiveStorage::Attachment.find_by(:blob_id => params[:blob_id]).purge
      redirect_to "/folders/#{params[:folder_id]}"
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
        params.require(:folder).permit(:name, :parent_id, :index_referrer)
    end

end

