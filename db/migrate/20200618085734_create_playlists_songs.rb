class CreatePlaylistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists_songs do |t|
      t.integer :playlist_id
      t.integer :song_id

      t.timestamps
    end
  end
end
