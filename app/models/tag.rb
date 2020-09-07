class Tag < ApplicationRecord
    has_many :taggings
    has_many :blobs, :through => :taggings,  class_name: 'ActiveStorage::Blob'
end
