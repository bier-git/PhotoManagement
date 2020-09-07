class PhotoDetailsController < ApplicationController

    def show    
        @photo = ActiveStorage::Blob.find(params[:blob_id])
    end

    def delete_attachment
        raise params.inspect
        ActiveStorage::Attachment.find_by(:blob_id => params[:blob_id]).purge
        redirect_to "/folders/#{params[:folder_id]}"
    end

    def edit
       @photo = ActiveStorage::Blob.find(params[:id])
    end

    def update
        @photo = ActiveStorage::Blob.find(params[:id])
        @photo.update(photographer_id: params[:photographer_id], shooting_date: params[:shooting_date])
        if @photo.tags.empty? 
            params[:tag_ids].reject {|k| k == ""}.each do |tag|
                @photo.tags << Tag.find(tag)
            end
        else
            @photo.tags.destroy_all
            @photo.tags << Tag.where(id: params[:tag_ids].reject {|k| k == ""})
        end 
        redirect_to "/folders/1"
    end

end