class PhotosController < ApplicationController

    before_action :set_active_storage_host

    def index
        @photos = Photo.with_attached_photos.search(params[:search], params[:tag]).includes(:tags)
    end
    
    def show    
        @photo = Photo.find(params[:id]).photos.blobs.find(params[:blob_id])
        @meta_data =  Photo.find(params[:id])
    end

    def edit
        @file = ActiveStorage::Blob.find(params[:id])
        @photo = Photo.find(ActiveStorage::Attachment.find_by(blob_id: params[:id]).record_id)
    end

    def update
        @file = ActiveStorage::Blob.find(params[:id])
        @photo = Photo.find(ActiveStorage::Attachment.find_by(blob_id: params[:id]).record_id)
        @photo.update(shooting_date: params[:photo][:shooting_date], tag_ids: params[:photo][:tag_ids], photographer_id: params[:photo][:photographer_id])
        redirect_to @file
    end

    def destroy
        @folder_id = Photo.find(params[:id]).folder_id
        if Photo.find(params[:id]).photos.count(:id) > 1
            Photo.find(params[:id]).photos.attachments.find_by(blob_id: "#{params[:blob_id]}").purge
        else
            Photo.find(params[:id]).destroy 
        end
        redirect_to "/folders/#{@folder_id}"
    end

    def download_image
        @files = Photo.photos.p
        redirect_to @photo.service_url
        Photo.find(params[:photo_id]).update(download_date: Date.current, delete_date: (Date.current + 1.year))
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.create(photo_params.merge({download_date: Date.current, delete_date: (Date.current + 1.year)}))
        @photo.update(download_date: Date.current, delete_date: (Date.current + 1.year))
        redirect_to "/folders/#{@photo.folder_id}"
    end

    

    private

    def photo_params

        params.require(:photo).permit(:shooting_date, :folder_id, :photographer_id, :search, :tag_list, :tag, { tag_ids: [] }, :tag_ids, permissions: [], photos: [])

    end

    def set_active_storage_host
        ActiveStorage::Current.host = request.base_url
    end  
end