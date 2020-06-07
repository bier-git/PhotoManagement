class ZipStreamingController < ApplicationController
    include ActionController::Live
  
    def download
      @photo = Photo.joins(:photos_attachments).where(:folder_id => params[:folder_id])
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
        @photo.each do |file|
        file.photos.where(:blob_id => params[:selected_ids].reject {|k| k == "0"}).each do |doc|
          zip.write_deflated_file(doc.filename.to_s) do |file_writer|
            doc.blob.download do |chunk|
              file_writer << chunk 
              end
          end
        end
        end
      end
    ensure
      response.stream.close
    end
  end