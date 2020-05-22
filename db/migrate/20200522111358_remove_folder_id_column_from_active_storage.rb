class RemoveFolderIdColumnFromActiveStorage < ActiveRecord::Migration[6.0]
  def change
    remove_column :active_storage_attachments, :folder_id, :integer
  end
end
