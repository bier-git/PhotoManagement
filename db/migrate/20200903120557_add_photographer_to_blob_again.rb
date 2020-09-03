class AddPhotographerToBlobAgain < ActiveRecord::Migration[6.0]
  def change
    add_reference(:active_storage_blobs, :photographer, foreign_key: true)
  end
end
