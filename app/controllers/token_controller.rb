class TokenController < BaseController
  def create
    email, password = token_params.values_at(:email, :password)
    user = User.find_by(email: email)
    return error_response(:unauthorized, 'Invalid user credentials!') if user.nil? or !user.valid_password?(password)
    success_response('success', payload(user), 'User token generated successfully')
  end

  private
  def payload(user)
    return nil unless user and user.id
    {token: JwtToken.encode({user_id: user.id})}
  end

  def token_params
    params.permit(:email, :password)
  end
end