class PlaylistsSong < ApplicationRecord
  belongs_to :playlist 
  belongs_to :song
  validates_uniqueness_of :song_id, scope: :playlist_id
end
