class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, presence: true
  validates :user_id, presence: true

  def self.open(params)
    account = new(params)
    puts "Creating a account with #{account.attributes}"
    account.save!
  end

  def self.deposit(account, amount)
    message = "Depositing #{amount} on account #{account.name}"
    return false unless self.amount_valid?(amount)
    ActiveRecord::Base.transaction do
      account.balance = (account.balance += amount).round(2)
      account.save!
      transaction = Transaction.create_transaction(account, 'Deposit', amount, message)
      transaction.save!
    end
  end

  def self.withdraw(account, amount)
    message = "Withdrawing #{amount} on account #{account.name}"
    response = self.amount_valid?(amount, account.balance)
    return response unless response[:success]
    ActiveRecord::Base.transaction do
      account.balance = (account.balance -= amount).round(2)
      account.save!
      transaction = Transaction.create_transaction(account, 'Withdraw', amount, message)
      transaction.save!
    end
  end

  def self.transfer(account, recipient, amount)
    puts "Transfering #{amount} from account #{account.id} to account #{recipient.id}"
    response = self.amount_valid?(amount, account.balance)
    return response unless response[:success]
    ActiveRecord::Base.transaction do
      self.withdraw(account, amount)
      self.deposit(recipient, amount)
    end
  end

  def self.transactions(account, no_records)
   puts "Last #{no_records} transactions from account #{account.id}"
   account.transactions.statement(no_records).to_json
  end

  private
  def self.amount_valid?(amount, balance)
    if amount <= 0
      return {success: false, message: 'Transaction failed! Amount must be greater than 0.00'}
    elsif balance < amount
       return {success: false, message:'Transaction failed! Insufficient funds'}
    end
    return {success: true}
  end
end
