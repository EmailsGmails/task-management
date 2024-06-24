class Task < ApplicationRecord
  belongs_to :assigned_to, class_name: 'User', foreign_key: 'assigned_to_id', optional: true
  belongs_to :assigned_by, class_name: 'User', foreign_key: 'assigned_by_id', optional: true
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true

  validates :name, presence: true
  enum status: { draft: "Draft", open: "Open", pending: "Pending", in_progress: "In Progress", completed: "Completed" }

  validate :must_have_assigned_user_if_required
  validate :due_date_cannot_be_in_the_past, on: [:create, :edit, :update]

  scope :with_status, ->(status) { where(status: status) if status.present? }
  scope :order_by_status, -> { order(:status) }
  scope :order_by_due_date, -> { order(:due_date) }

  def overdue?
    due_date.present? && due_date < Date.today && !completed?
  end

  private

  def must_have_assigned_user_if_required
    if due_date.present? && assigned_to.nil?
      errors.add(:base, 'A task with a due date must belong to an assigned user')
    end
  end

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end
end
