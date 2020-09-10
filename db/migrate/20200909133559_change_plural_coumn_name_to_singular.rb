class ChangePluralCoumnNameToSingular < ActiveRecord::Migration[6.0]
  def change
    rename_column :permissions, :active_storage_attachments_id, :active_storage_attachment_id
    rename_column :permissions, :active_storage_blobs_id, :active_storage_blob_id
  end
end
