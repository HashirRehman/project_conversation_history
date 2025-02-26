# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:valid_attributes) { attributes_for(:comment, user_id: user.id, project_id: project.id) }
  let(:invalid_attributes) { { text_content: "", user_id: user.id, project_id: project.id } }

  before do
    sign_in user
  end

  describe "POST /projects/:project_id/comments" do
    context "with valid attributes" do
      it "creates a new comment" do
        expect {
          post project_comments_path(project), params: { comment: valid_attributes }, as: :turbo_stream
        }.to change(Comment, :count).by(1)

        expect(response).to have_http_status(:success)
      end

      it "broadcasts the comment via Turbo Streams" do
        expect {
          post project_comments_path(project), params: { comment: valid_attributes }, as: :turbo_stream
        }.to have_broadcasted_to("project_#{project.id}_comments")
      end
    end

    context "with invalid attributes" do
      it "does not create a comment" do
        expect {
          post project_comments_path(project), params: { comment: invalid_attributes }, as: :turbo_stream
        }.not_to change(Comment, :count)
      end
    end
  end
end
