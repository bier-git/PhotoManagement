class AddBlobToTagging < ActiveRecord::Migration[6.0]
  def change
    add_reference(:taggings, :active_storage_blob, foreign_key: true)
  end
end
