class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :privacy
      t.integer :user_id

      t.timestamps
    end
  end
end
