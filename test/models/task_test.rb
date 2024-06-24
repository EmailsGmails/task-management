require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @task = Task.new(name: "Test Task", assigned_to: @user, created_by: @user)
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "name should be present" do
    @task.name = ""
    assert_not @task.valid?
  end

  test "should belong to assigned_to" do
    assert_respond_to @task, :assigned_to
  end

  test "should belong to assigned_by" do
    assert_respond_to @task, :assigned_by
  end

  test "should belong to created_by" do
    assert_respond_to @task, :created_by
  end

  test "should validate presence of assigned_to if due_date is present" do
    @task.due_date = Date.today
    @task.assigned_to = nil
    assert_not @task.valid?
  end

  test "task should not be overdue if due date is in the future" do
    task = Task.create!(
      name: "Future Task",
      description: "This task is in the future",
      due_date: Date.tomorrow,
      status: "open",
      assigned_to: @user,
      assigned_by: @user,
      created_by: @user
    )
    assert_not task.overdue?
  end

  test "task should not allow due date in the past on creation" do
    task = Task.new(
      name: "Invalid Task",
      description: "This task has an invalid due date",
      due_date: Date.yesterday,
      status: "open",
      assigned_to: @user,
      assigned_by: @user,
      created_by: @user
    )
    assert_not task.valid?
    assert_includes task.errors[:due_date], "can't be in the past"
  end

  test "task should not allow due date in the past on update" do
    task = Task.create!(
      name: "Valid Task",
      description: "This task has a valid due date",
      due_date: Date.tomorrow,
      status: "open",
      assigned_to: @user,
      assigned_by: @user,
      created_by: @user
    )
    task.due_date = Date.yesterday
    assert_not task.valid?
    assert_includes task.errors[:due_date], "can't be in the past"
  end
end
