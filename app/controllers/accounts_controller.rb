class AccountsController < ApplicationController
  before_action :authenticate!

  def create
    return head :unprocessable_entity unless Account.open(account_params)
    render {code: 201, status: 'Created', message: 'Account created successfully'}
  end

  def deposit
    account = Account.find(params[:id])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.deposit(account, amount)
    render json: {code:200, status: 'Desposited', message: "#{amount} deposited successfully"}
  end

  def withdraw
    account = Account.find(params[:id])
    return json: {code: 404, success: false, status: 'Not Found', message: 'Account Not found'} unless account
    return json: {code: 500, success: false, status: :unprocessable_entity} unless Account.withdraw(account, amount)
    render json: {code: 200, success: true, status: 'Withdrawn', message: "#{amount} withdrawn successfully"}
  end

  def transfer
    account = Account.find(params[:id])
    return head :not_found unless account

    recipient_param = params.permit(:recipient_id)
    recipient = Account.find(recipient_param[:recipient_id])
    return head :not_found unless recipient

    return head :unprocessable_entity unless Account.transfer(account, recipient, amount)
    render json: {code:200, status: 'transfered', message: "#{amount} transfered successfully"}
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
