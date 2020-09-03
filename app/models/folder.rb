class Folder < ApplicationRecord
    acts_as_tree
    has_many_attached :photos
    has_many_attached :permissions
end