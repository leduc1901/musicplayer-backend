class Singer < ApplicationRecord
    has_many :songs
    has_one_attached :image
end
