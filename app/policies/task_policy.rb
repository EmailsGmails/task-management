class TaskPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    @user = user
    @record = record
  end

  def index?
    user_is_owner_or_assigner_or_creator?
  end

  def show?
    user_is_owner_or_assigner_or_creator?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user_is_owner_or_assigner_or_creator?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_owner_or_assigner_or_creator?
  end

  class Scope < Scope
    def resolve
      scope.where("assigned_to_id = ? OR assigned_by_id = ? OR created_by_id = ?", user.id, user.id, user.id)
    end
  end

  private

  def user_is_owner_or_assigner_or_creator?
    record.assigned_to&.id == user.id || record.assigned_by&.id == user.id || record.created_by.id == user.id
  end
end
