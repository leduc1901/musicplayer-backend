class Song < ApplicationRecord
    belongs_to :category 
    belongs_to :singer
    has_one_attached :song_url

    has_many :playlists_songs 
    has_many :playlists, through: :playlists_songs
    
    validates :name, presence:true , length:{minimum:5 , maximum:50}, uniqueness:true   
    validates :category_id, presence: true
    validates :singer_id, presence: true
end
