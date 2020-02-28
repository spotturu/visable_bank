module Accounts
	module Withdrawns
	  	def withdraw
		    begin
			    account = Account.find(params[:id])
			    response = Account.withdraw(account, amount)
			    return error_response(:unprocessable_entity, response[:message]) unless response[:success]
			    message = "#{amount} withdrawn successfully"
			    send_notification(account, message)
			    success_response('success', nil,  message)
			    rescue ActiveRecord::RecordNotFound => e
			      error_response(:not_found, "Record Not Found!")
			    rescue StandardError => e
			      error_response(:internal_server_error, e.message)
		    end
	  	end
	end
end