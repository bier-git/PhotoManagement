class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :active_storage_blob
end
