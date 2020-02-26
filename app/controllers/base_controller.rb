class BaseController < ApplicationController
	include ErrorStatus
	
	def return_resp(status, response, msg)
		success = rest_api_status(status.to_s)
		render json: {code: success[0], success: true, status: success[1], response: response, message: msg }
	end

	def return_error(err_type, msg)
		error = rest_api_status(err_type.to_s)
		render json: {code: error[0], success: false, status: error[1], message: msg}
	end
end