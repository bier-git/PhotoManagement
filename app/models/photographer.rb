class Photographer < ApplicationRecord
    has_many :active_storage_blobs
end