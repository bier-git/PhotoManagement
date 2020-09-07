class AddShootingDateToActiveStorageBlob < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_blobs, :shooting_date, :date
  end
end
