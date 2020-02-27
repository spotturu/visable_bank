class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :details,  null: false
      t.float	:amount, null: false, default: 0.0
      t.string	:transaction_number, null: false
      t.string	:transaction_type, null: false
      t.string :balance, null: false, default: 0.0
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
