class FundingPolicy < ApplicationPolicy
  def create?
    user.has_role?(:beelover)
  end

  def show?
    user.has_role?(:beekeeper) && (Apiary.find(Hive.find(record.hive_id).apiary_id).user_id == user.id)
  end

  class Scope < Scope
    def resolve
      if user.has_role?(:beelover)
        scope.where(user_id: user.id)
      elsif user.has_role?(:beekeeper)
        apiaries = Apiary.where(user_id: user.id)
        hives = Hive.where(apiary_id: apiaries.map(&:id))
        scope.where(hive_id: hives.map(&:id))
      else
        false
      end
    end
  end
end
