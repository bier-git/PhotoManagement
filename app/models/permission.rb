class Permission < ApplicationRecord
    belongs_to :attachment, class_name: 'ActiveStorage::Attachment'
    belongs_to :blob, class_name: 'ActiveStorage::Blob'
end