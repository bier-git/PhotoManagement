class RemoveColumnPhotoId < ActiveRecord::Migration[6.0]
    def change
      remove_column :photographers, :photo_id, :integer
    end
  end
  