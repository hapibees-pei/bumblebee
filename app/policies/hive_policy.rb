class HivePolicy < ApplicationPolicy
  def create?
    user.has_role?(:beekeeper)
  end

  def update?
    user.has_role?(:beekeeper)
  end

  def destroy?
    user.has_role?(:beekeeper)
  end

  class Scope < Scope
    def resolve
      if user.has_role?(:beelover)
        scope.all
      elsif user.has_role?(:beekeeper)
        apiaries = user.apiaries
        scope.where(apiary_id: apiaries.map(&:id))
      else
        false
      end
    end
  end
end
