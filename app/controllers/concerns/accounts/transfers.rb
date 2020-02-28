module Accounts
  module Transfers
    def transfer
      begin
        account = Account.find(params[:id])
        recipient_param = params.permit(:recipient_id)
        recipient = Account.find(recipient_param[:recipient_id])
        response = Account.transfer(account, recipient, amount)
        return error_response(:unprocessable_entity, response[:message] ) unless response[:success]
        send_notification(account, "#{amount} debited successfully")
        send_notification(recipient, "#{amount} credited successfully")
        success_response('success', nil,  "#{amount} transfered successfully")
        rescue ActiveRecord::RecordNotFound => e
          error_response(:not_found, "Record Not Found!")
        rescue StandardError => e
          error_response(:internal_server_error, e.message)
      end
    end
  end
end