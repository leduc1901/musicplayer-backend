class AddVerifyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :verify , :string

  end
end
