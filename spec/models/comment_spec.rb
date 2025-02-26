# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:comment) { create(:comment, user: user, project: project) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:text_content) }
    it { is_expected.to validate_length_of(:text_content).is_at_least(3).is_at_most(200) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'Callbacks' do
    it 'broadcasts the comment after creation' do
      expect {
        create(:comment, user: user, project: project)
      }.to have_broadcasted_to("project_#{project.id}_comments")
    end
  end
end
