class Task < ApplicationRecord
  belongs_to :user, polymorphic: true, optional: true
  validates :name, presence: true
  enum status: { draft: "Draft", open: "Open", pending: "Pending", in_progress: "In Progress", completed: "Completed" }

  validate :must_have_user_if_required

  private

  def must_have_user_if_required
    if due_date.present? && user_id.nil?
      errors.add(:base, 'A task with a due date must belong to a user')
    end
  end

end
