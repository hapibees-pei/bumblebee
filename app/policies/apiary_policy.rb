class ApiaryPolicy < ApplicationPolicy
  def create?
    user.has_role?(:beekeeper)
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
