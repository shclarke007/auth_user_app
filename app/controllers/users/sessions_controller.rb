# frozen_string_literal: true

# A Ruby controller for user sessions that handles signing in and signing out, and
# responds with JSON.

class Users::SessionsController < Devise::SessionsController
  respond_to :json 
  
  private
  def respond_with(resource, options={})
    render json: {
      status: { code: 200, message: "User signed in successfully", token: resource.jti }
    }, status: :ok
  end
  
  def respond_to_on_destroy 
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    
    if current_user
      render json: {
        status: 200,
        message: "Sign out successful"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "User has no active session"
      }, status: :unauthorized
    end
  end
end
