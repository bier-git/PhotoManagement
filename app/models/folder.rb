class Folder < ApplicationRecord
    acts_as_tree
    has_many :photos 
    has_many :permissions 
end