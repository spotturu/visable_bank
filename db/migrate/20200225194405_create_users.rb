class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :crypted_password
      t.integer :mobile_number
      t.timestamps
    end
  end
end
