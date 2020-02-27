class AccountsController < BaseController
  before_action :authenticate!
  include SmsNotification

  def create
    account = Account.open(account_params)
    return head :unprocessable_entity unless account
    return_resp('Created', account,  'Account created successfully')
  end

  def deposit
    account = Account.find(params[:id])
    return return_error(:not_found, 'Account not found!') unless account 
    return head :unprocessable_entity unless Account.deposit(account, amount)
    message = "#{amount} deposited successfully"
    send_notification(account, message)
    return_resp('success', nil,  message)
  end

  def withdraw
    account = Account.find(params[:id])
    return return_error(:not_found, 'Account not found!') unless account
    return head :unprocessable_entity unless Account.withdraw(account, amount)
    message = "#{amount} withdrawn successfully"
    send_notification(account, message)
    return_resp('success', nil,  message)
  end

  def balance
    account = Account.find(params[:id])
    return return_error(:not_found, 'Account not found!') unless account
    message = "#{account.amount} - current balance amount"
    send_notification(account, message)
    return_resp('success', nil,  message)
  end

  def transfer
    account = Account.find(params[:id])
    return return_error(:not_found, 'Account not found!') unless account
    recipient_param = params.permit(:recipient_id)
    recipient = Account.find(recipient_param[:recipient_id])
    return return_error(:not_found, 'Recipient not found!') unless recipient
    return head :unprocessable_entity unless Account.transfer(account, recipient, amount)
    send_notification(account, "#{amount} debited successfully")
    send_notification(recipient, "#{amount} credited successfully")
    return_resp('success', nil,  "#{amount} transfered successfully")
  end

  def mini_statement
    account = Account.find(params[:id])
    return head :not_found unless account
    params[:no_of_days] ||= 10
    transactions =  Account.transactions(account, params[:no_of_days])
    return head :unprocessable_entity unless transactions
    return_resp('success', transactions, "Recent transactions successfully")
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
