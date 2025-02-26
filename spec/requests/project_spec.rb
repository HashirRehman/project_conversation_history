# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:valid_attributes) { attributes_for(:project) }
  let(:invalid_attributes) { { title: "", description: "" } }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders the index page" do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "renders the show page" do
      get project_path(project)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      it "creates a new project" do
        expect {
          post projects_path, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)

        expect(response).to redirect_to(projects_path)
        follow_redirect!
        expect(response.body).to include("Project created!")
      end
    end

    context "with invalid attributes" do
      it "does not create a project and renders new" do
        expect {
          post projects_path, params: { project: invalid_attributes }
        }.not_to change(Project, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid attributes" do
      it "updates the project" do
        patch project_path(project), params: { project: { title: "Updated Title" } }
        project.reload
        expect(project.title).to eq("Updated Title")
        expect(response).to redirect_to(project)
      end
    end
  end
end
