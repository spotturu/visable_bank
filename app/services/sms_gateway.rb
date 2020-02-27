require 'nexmo'

class SmsGateway
	def initialize
	    @client = Nexmo::Client.new(
	    	api_key:Rails.application.secrets[:sms_api_key],
			api_secret: Rails.application.secrets[:sms_api_secret]
	    	)
	end

	def send_sms(acc_name, mobile_number, text)
		begin
			@client.sms.send(
				from: acc_name,
				to: mobile_number,
				text: text
			)
		rescue => e 
			return e
		end
	end
end