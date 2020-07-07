class RenameIndexPlaylistsSongs < ActiveRecord::Migration[6.0]
  def change
    rename_column :playlists_songs, :index, :song_index
  end
end
