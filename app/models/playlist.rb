class Playlist < ApplicationRecord
    belongs_to :user
    has_many :playlists_songs 
    has_many :songs, through: :playlists_songs
    accepts_nested_attributes_for :playlists_songs , allow_destroy: true
end
