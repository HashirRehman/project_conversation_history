# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(3).is_at_most(20) }
    it { is_expected.to validate_length_of(:description).is_at_most(200) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:comments) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status).with_values(todo: 0, in_progress: 1, done: 2).with_prefix }
  end

  describe 'Callbacks' do
    context 'after_create_commit' do
      it 'broadcasts project creation' do
        expect {
          create(:project) # Use FactoryBot's factory
        }.to have_broadcasted_to("projects")
      end
    end

    context 'after_update_commit' do
      before { Current.user = user } # Set the current user before status update

      it 'broadcasts status update' do
        expect {
          project.update!(status: :done)
        }.to have_broadcasted_to("project_#{project.id}")
      end

      it 'creates a comment when status changes' do
        expect {
          project.update!(status: :done)
        }.to change { project.comments.count }.by(1)

        comment = project.comments.last
        expect(comment.text_content).to eq("#{user.name} updated the status from Todo to Done")
      end
    end
  end
end
