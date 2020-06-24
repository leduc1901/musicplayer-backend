class CreatePlaylistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists_songs do |t|
      t.references :playlist 
      t.references :song
      t.timestamps
    end
  end
end
