class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :url
      t.integer :category_id
      t.integer :singer_id

      t.timestamps
    end
  end
end
