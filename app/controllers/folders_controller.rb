class FoldersController < ApplicationController
   
    include ActionController::Live
    include ZipTricks::RailsStreaming

    def index 
        @folders = Folder.roots
    end
      
    def show 
        @folder = Folder.find(params[:id]) 
        @sub_folders = @folder.children
        @sub_files = @folder.photos.where(folder_id: " #{params[:id]}")
    end

    def download_files
        @blob_ids = Folder.find(params[:folder_id])

        zipname = "test.zip"
        disposition = ActionDispatch::Http::ContentDisposition.format(disposition: "attachment", filename: zipname)
    
        response.headers["Content-Disposition"] = disposition
        response.headers["Content-Type"] = "application/zip"
        response.headers.delete("Content-Length")
        response.headers["Cache-Control"] = "no-cache"
        response.headers["Last-Modified"] = Time.now.httpdate.to_s
        response.headers["X-Accel-Buffering"] = "no"
    
        writer = ZipTricks::BlockWrite.new do |chunk| 
          response.stream.write(chunk)
        end
        ZipTricks::Streamer.open(writer) do |zip|
          @blob_ids.photos.each do |doc|
            zip.write_deflated_file(doc.filename.to_s) do |file_writer|
              doc.blob.where(:id => (params[:selected_ids].reject {|k| k == "0"})).download do |chunk|
                file_writer << chunk
              end
            end
          end
        end
      ensure
        response.stream.close
    end

    def delete_image_attachment
        @image = ActiveStorage::Blob.find_signed(params[:id])
        @image.purge
        redirect_to collections_url
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