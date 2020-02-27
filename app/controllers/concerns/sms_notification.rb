module SmsNotification

def send_notification(account, message)
	SmsGateway.new.send_sms(account.name, account.user.mobile_number, message)
end

end