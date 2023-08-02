# frozen_string_literal: true

class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!
  
   before_action :authorize_admin, only: [:create, :add_users]

  def create
    group = Group.new(group_params)
    group.users << current_user

    if group.save
      render json: {
        status: { code: 200, message: 'Group created successfully', data: group }
      }, status: :created
    else
      render json: {
        status: { message: 'Group could not be created successfully', errors: group.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name)
  end
end
