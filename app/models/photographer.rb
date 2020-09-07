class Photographer < ApplicationRecord
    has_many :blobs,  class_name: 'ActiveStorage::Blob'
end