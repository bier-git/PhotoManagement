class ZipStreamingController < ApplicationController
    include ActionController::Live
  
    def download
      @folder = Folder.find(params[:folder_id]) 
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
        @folder.photos.blobs.where(:id => params[:blob_id].reject {|k| k == "0"}).each do |doc|
          zip.write_deflated_file(doc.filename.to_s) do |file_writer|
            doc.download do |chunk|
              file_writer << chunk 
            end
          end
        end
      end
    ensure
      response.stream.close
    end
  end