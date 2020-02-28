module Accounts
	module Deposits
		def deposit
			begin
			    account = Account.find(params[:id])
			    return error_response(:unprocessable_entity, 'Unable to process the request!' ) unless Account.deposit(account, amount)
			    message = "#{amount} deposited successfully"
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