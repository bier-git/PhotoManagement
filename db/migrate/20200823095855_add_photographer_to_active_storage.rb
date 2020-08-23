class AddPhotographerToActiveStorage < ActiveRecord::Migration[6.0]
  def change
    add_reference(:active_storage_attachments, :photographer, foreign_key: { to_table: :photographers })
  end
end
