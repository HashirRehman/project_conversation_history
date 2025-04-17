# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  %i[create?].each do |method|
    define_method method do
      user.present?
    end
  end

  %i[update? destroy?].each do |method|
    define_method method do
      record.user == user
    end
  end
end
