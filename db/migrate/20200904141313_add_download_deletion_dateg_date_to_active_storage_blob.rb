class AddDownloadDeletionDategDateToActiveStorageBlob < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_blobs, :download_date, :date
    add_column :active_storage_blobs, :deletion_date, :date
  end
end
