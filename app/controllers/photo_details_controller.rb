class PhotoDetailsController < ApplicationController

    def show    
        @photo = ActiveStorage::Blob.find(params[:blob_id])
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
        redirect_to  folder_photo_detail_path(@photo)
    end

    def search
        @photos = ActiveStorage::Blob.all.search(params[:search], params[:tag]).includes(:tags)
    end

end