module Accounts
  module Statements
      def mini_statement
        begin
          account = Account.find(params[:id])
          params[:no_of_days] ||= 10
          transactions =  Account.transactions(account, params[:no_of_days])
          return error_response(:unprocessable_entity, 'Unable to process the request!' ) unless transactions
          success_response('success', transactions, "Recent transactions successfully")
          rescue ActiveRecord::RecordNotFound 
            error_response(:not_found, "Record Not Found!")
          rescue StandardError => e
            error_response(:internal_server_error, e.message)
        end
      end
  end
end