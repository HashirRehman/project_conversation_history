# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:valid_attributes) { attributes_for(:project) }
  let(:invalid_attributes) { { title: '', description: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get projects_path
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get project_path(project)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new project' do
        expect {
          post projects_path, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
      end

      it 'redirects to the projects index' do
        post projects_path, params: { project: valid_attributes }
        expect(response).to redirect_to(projects_path)
        expect(flash[:notice]).to eq('Project created!')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new project' do
        expect {
          post projects_path, params: { project: invalid_attributes }
        }.not_to change(Project, :count)
      end

      it 'renders the new template' do
        post projects_path, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the project' do
        patch project_path(project), params: { project: { status: 'in_progress' } }
        project.reload
        expect(project.status).to eq('in_progress')
      end

      it 'redirects to the project' do
        patch project_path(project), params: { project: { status: 'done' } }
        expect(response).to redirect_to(project)
        expect(flash[:notice]).to eq('Project updated successfully.')
      end
    end
  end
end
