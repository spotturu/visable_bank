module Accounts
	module Balances
		def balance
		    begin
		      account = Account.find(params[:id])
		      message = "#{account.balance} - current balance amount"
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
