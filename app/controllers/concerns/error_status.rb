module ErrorStatus
	REST_API_STATUS_CODE = Hash[
		'401': 'unauthorized', '200': 'success', '201': 'Created' ,'400': 'bad request',
		'422': 'unprocessable_entity',
		'404': 'not_found',	'500': 'internal_server_error'
	]
	def rest_api_status(status)
		error_details = REST_API_STATUS_CODE.select{|k,v| v == status}
		return error_details.to_a[0] if error_details.present?
		['500', REST_API_STATUS_CODE['500']]
	end
end