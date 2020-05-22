class PhotosController < ApplicationController

    before_action :set_active_storage_host

    def index
        @photos = Photo.with_attached_photos.search(params[:search], params[:tag]).includes(:tags)
    end
    
    def show    
        @photo = Photo.find(params[:id])
    end

    def edit
        @photo = Photo.find(params[:id])
    end

    def update
        @photo = Photo.find(params[:id])
        @photo.update(photo_params)
        redirect_to @photo
    end

    def destroy
        Photo.find(params[:id]).destroy

        redirect_to "/"
    end

    def download_image
        @photo = Photo.find(params[:photo_id]).photos.first
        redirect_to @photo.service_url
        Photo.find(params[:photo_id]).update(download_date: Date.current, delete_date: (Date.current + 1.year))
    end

    def delete_attachment
        @photo = ActiveStorage::Attachment.find(params[:id])
        @photo.purge.photos.first
        redirect_to "/"
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.create(photo_params.merge({download_date: Date.current, delete_date: (Date.current + 1.year)}))
        @photo.update(download_date: Date.current, delete_date: (Date.current + 1.year))
        redirect_to "/folders"
    end

    private

    def photo_params

        params.require(:photo).permit(:shooting_date, :folder_id, :photographer_id, :search, :tag_list, :tag, { tag_ids: [] }, :tag_ids, permissions: [], photos: [])

    end

    def set_active_storage_host
        ActiveStorage::Current.host = request.base_url
    end  
end