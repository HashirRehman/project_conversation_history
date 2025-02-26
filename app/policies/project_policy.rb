# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  %i[index? show? create? update?].each do |method|
    define_method method do
        user.present?
    end
  end
end
