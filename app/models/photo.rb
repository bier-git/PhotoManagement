class Photo < ApplicationRecord

    has_many_attached :photos
    has_many_attached :permissions
    has_many :taggings
    has_many :tags, through: :taggings, dependent: :destroy

    scope :with_tag, ->(tag) do
        joins("inner join taggings on taggings.photo_id = photos.id inner join tags on tags.id = taggings.tag_id").
        where("lower(tags.name) LIKE ?", "%#{tag.downcase}%")
    end

    scope :with_photographer, ->(photographer) do
        joins("inner join photographers on photographers.id= photos.photographer_id").
        where("lower(photographers.name) LIKE ?", "%#{photographer.downcase}%")
    end

    def self.search(search, tag)
        @photos = Photo.all
        if search
            if @photos.with_photographer(search).exists?
                    @photos = @photos.with_photographer(search)
            elsif @photos.with_tag(search).exists?
                    @photos = @photos.with_tag(search)
            else  @photos = @photos.where("cast(strftime('%Y', shooting_date) as int) = ?", "#{search}")                
            end
        end
        @photos = @photos.with_tag(tag).includes(:tags) if tag
        @photos
    end
    
    def self.tag_counts
        Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end
    
    def tag_list
        tags.map(&:name).join(', ')
    end
    
    def tag_list=(names)
        self.tags = names.split(',').map do |n|
          Tag.where(name: n.strip).first_or_create!
        end
    end


    
end