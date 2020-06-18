class Song < ApplicationRecord
    belongs_to :category 
    belongs_to :singer
    has_many :playlists_songs 
    has_many :playlists, through: :playlists_songs
    

end
