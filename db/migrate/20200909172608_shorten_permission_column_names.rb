class ShortenPermissionColumnNames < ActiveRecord::Migration[6.0]
  def change
      rename_column :permissions, :active_storage_attachment_id, :attachment_id
      rename_column :permissions, :active_storage_blob_id, :blob_id
  end
end
