class AddSongIndexToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists_songs, :index, :integer

  end
end
