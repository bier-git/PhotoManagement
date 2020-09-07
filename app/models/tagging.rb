class Tagging < ApplicationRecord
  belongs_to :tag, inverse_of: :taggings
  belongs_to :blob, class_name: 'ActiveStorage::Blob'
end
