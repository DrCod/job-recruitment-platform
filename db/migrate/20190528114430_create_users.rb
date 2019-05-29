class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :address
      t.integer :phone
      t.string :password
      t.string :password_confirm

      t.timestamps
    end
  end
end
