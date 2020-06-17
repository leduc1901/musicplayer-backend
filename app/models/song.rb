class Song < ApplicationRecord
    belongs_to :category 
    belongs_to :singer
end
