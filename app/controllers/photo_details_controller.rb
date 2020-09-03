class PhotoDetailsController < ApplicationController

    def show    
        @photo = Folder.find(params[:folder_id]).photos.blobs.find(params[:blob_id])
    end

    def delete_attachment
        ActiveStorage::Attachment.find_by(:blob_id => params[:blob_id]).purge
        redirect_to "/folders/#{params[:folder_id]}"
    end

end