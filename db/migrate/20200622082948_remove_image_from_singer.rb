class RemoveImageFromSinger < ActiveRecord::Migration[6.0]
  def change
    remove_column :singers, :image, :string

  end
end
