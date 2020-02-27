class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :crypted_password, null: false
      t.integer :mobile_number, null: false
      t.timestamps
    end
  end
end
