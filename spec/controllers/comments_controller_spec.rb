# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:valid_attributes) { attributes_for(:comment).merge(user_id: user.id, project_id: project.id) }
  let(:invalid_attributes) { { text_content: '', user_id: user.id, project_id: project.id } }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        expect {
          post :create, params: { project_id: project.id, comment: valid_attributes }, format: :turbo_stream
        }.to change(Comment, :count).by(1)
      end

      it 'broadcasts the comment via Turbo Streams' do
        expect {
          post :create, params: { project_id: project.id, comment: valid_attributes }, format: :turbo_stream
        }.to have_broadcasted_to("project_#{project.id}_comments")
      end
    end
  end
end
