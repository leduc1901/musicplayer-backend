class Category < ApplicationRecord
    has_many :songs
    def to_param
        slug
      end
end
