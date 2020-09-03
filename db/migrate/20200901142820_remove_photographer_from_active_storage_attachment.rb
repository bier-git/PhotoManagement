class RemovePhotographerFromActiveStorageAttachment < ActiveRecord::Migration[6.0]
    def change
      remove_reference(:active_storage_attachments, :photographer, foreign_key: { to_table: :photographers })
    end
end
