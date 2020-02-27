class Transaction < ApplicationRecord
	belongs_to :account
	
	TRANSACTION_TYPES = ["Withdraw","Deposit"]

	validates :account_id, presence: true
  	validates :amount, presence: true, numericality: true
  	validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES}

	before_validation :load_defaults

	scope :statement, -> (no_records) do
		order(created_at: :desc).limit(no_records)
	end

	def self.create_transaction(account, transaction_type, amount, details)
    	create(account_id: account.id, balance: account.balance, transaction_type: transaction_type, amount: amount, details: details)
  	end

  	private
	
	def load_defaults
    	if self.new_record?
      		self.transaction_number = SecureRandom.uuid
    	end
  	end
end
