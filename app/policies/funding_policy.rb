class FundingPolicy < ApplicationPolicy
  def create?
    user.has_role?(:beelover)
  end

  class Scope < Scope
    def resolve
      if user.has_role?(:beelover)
        scope.where(user_id: user.id)
      else
        false
      end
    end
  end
end
