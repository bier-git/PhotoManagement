class AddParentIdColumnToPhotos < ActiveRecord::Migration[6.0]
  def change
      add_column :photos, :folder_id, :integer

  end
end
