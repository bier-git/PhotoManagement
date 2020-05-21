class AddColumnFolderIdActiveStorage < ActiveRecord::Migration[6.0]
  def change
        add_column :active_storage_attachments, :folder_id, :integer
  end
end
