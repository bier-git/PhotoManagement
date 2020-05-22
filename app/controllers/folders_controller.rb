class FoldersController < ApplicationController
    def index 
        @folders = Folder.roots
    end
      
    def show 
        @folder = Folder.find(params[:id]) 
        @sub_folders = @folder.children
        @sub_files = @folder.photos.where(folder_id: "#{params[:id]}")
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
    end
      
    def destroy 
        @folder = Folder.find(params[:id]) 
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