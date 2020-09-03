class AddTagToActiveStorage < ActiveRecord::Migration[6.0]
  def change
      add_reference(:active_storage_blobs, :tagging, foreign_key: { to_table: :taggings })
  end
end
