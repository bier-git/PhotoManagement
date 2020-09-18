class SearchController < ApplicationController

    def index

        @photos = ActiveStorage::Blob.all.search(params[:q], params[:tag]).includes(:tags)

    end
    

    
end