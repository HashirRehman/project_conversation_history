# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
    %i[create?].each do |method|
      define_method method do
          user.present?
      end
    end
end
