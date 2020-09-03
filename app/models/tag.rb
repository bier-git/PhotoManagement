class Tag < ApplicationRecord
    has_many :taggings
    has_many :active_storage_blobs, :through => :taggings
end
