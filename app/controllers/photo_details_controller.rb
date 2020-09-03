class PhotoDetailsController < ApplicationController

    def show    
        @photo = ActiveStorage::Blob.find(params[:blob_id])
    end

    def delete_attachment
        ActiveStorage::Attachment.find_by(:blob_id => params[:blob_id]).purge
        redirect_to "/folders/#{params[:folder_id]}"
    end

    def edit
       @photo = ActiveStorage::Blob.find(params[:id])
    end

    def update
        ActiveStorage::Attachment.find_by(:blob_id => params[:blob_id])
        redirect_to "/folders/#{params[:folder_id]}"
    end

end