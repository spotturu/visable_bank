class AccountsController < BaseController
  before_action :authenticate!
  include SmsNotification
  include Accounts::Balances
  include Accounts::Deposits
  include Accounts::Withdrawns
  include Accounts::Transfers
  include Accounts::Statements

  def create
    account = Account.open(account_params)
    return head :unprocessable_entity unless account
    success_response('Created', account,  'Account created successfully')
  end

  private

  def account_params
    params.require(:account).permit(:name, :user_id)
  end

  def amount
    param = params.permit(:amount)
    param[:amount].to_f
  end
end
