# frozen_string_literal: true

# A custom controller for user registrations in a Ruby on Rails application that
# responds to JSON requests and overrides the default behavior of the Devise gem.
# Bearer token generated in response header

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json 
  
  private

  def sign_up_params
    params.permit(:username, :email, :password, :admin)
  end
  
  def respond_with(resource, options={})
    if resource.persisted?
      render json: { status: { code: 200, message: 'User sign up successful', data: resource }}, status: :created
    else 
      render json: {
        status: { message: 'User could not be created successfully', errors: resource.errors.full_messages } 
      }, status: :unprocessable_entity
    end
  end
end
