class AddColumnToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :parent_id, :integer
    add_column :comments, :reply, :integer ,  :default => 0
  end
end
