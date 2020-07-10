class AddDownloadsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :downloads , :integer

  end
end
