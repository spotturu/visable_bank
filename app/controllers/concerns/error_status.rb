module ErrorStatus
	REST_API_STATUS_CODE = Hash[
		'401': 'unauthorized', '200': 'success', '201': 'created' ,'400': 'bad request',
		'404': 'not_found',	'500': 'internal sever error' #Add if any additonal status codes here
	]
	def rest_api_status(status)
		error_details = REST_API_STATUS_CODE.select{|k,v| v == status}
		return error_details.to_a[0] if error_details.present?
		['500', REST_API_STATUS_CODE['500']]
	end
end