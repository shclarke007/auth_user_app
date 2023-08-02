# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json 
  
  private

  def sign_up_params
    params.permit(:username, :email, :password)
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
