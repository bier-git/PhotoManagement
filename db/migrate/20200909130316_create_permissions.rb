class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.references :active_storage_attachments, null: false, index: true, foreign_key: true
      t.references :active_storage_blobs, null: false, index: true, foreign_key: true
    end
  end
end
