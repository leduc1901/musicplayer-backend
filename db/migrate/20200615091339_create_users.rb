class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name , null: false , unique: true
      t.string :email , null: false , index: true, unique: true 
      t.string :password_digest
      t.string :role , null: false , default: 'user'
      t.timestamps
    end
  end
end
