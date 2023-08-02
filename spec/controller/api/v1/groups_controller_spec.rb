# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller, aggregate_failures: true  do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  before do
    sign_in user
  end

  describe 'POST /api/v1/groups' do
    it 'creates a new group' do
      group_name = Faker::Alphanumeric.unique.alphanumeric(number: 10)
      expect do
        post :create, params: { group: { name: group_name } }
      end.to change(Group, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json_response['status']['data']['name']).to eq(group_name)
    end

    it 'requires a name' do
      post :create, params: { group: {name: ''} }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response['status']['errors']).to include("Name can't be blank")
    end
  end

  describe 'POST /api/v1/groups/:id/users' do
    it 'can adds users to a group' do
      users = [create(:user), create(:user)]

      post :add_users, params: { group_id: group.id, users: users.map(&:id) }

      expect(group.users).to include(*users)

      expect(response).to have_http_status(:ok)
      expect(json_response['status']['data']['name']).to eq(group.name)
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end