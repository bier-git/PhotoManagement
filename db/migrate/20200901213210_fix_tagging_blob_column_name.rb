class FixTaggingBlobColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :taggings, :active_storage_blob_id, :blob_id
  end
end
