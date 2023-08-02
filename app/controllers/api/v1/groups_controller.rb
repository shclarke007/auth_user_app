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
  
  def add_users
    group = Group.find(params[:group_id])
    users = params[:users]

    users.each do |user_id|
      user = User.find(user_id)
      group.users << user
    end

    if group.save
      render json: {
        status: { code: 200, message: 'Users added to group successfully', data: group }
      }, status: :ok
    else
      render json: {
        status: { message: 'Users could not be added to group successfully', errors: group.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name)
  end
  
  def authorize_admin
    unless current_user.admin?
      render json: {
        status: { message: 'You do not have permission to do that' }
      }, status: :unauthorized
    end
  end
end
