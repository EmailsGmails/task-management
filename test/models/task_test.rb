require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @task = Task.new(
      title: "Test Task",
      description: "Test Description",
      due_date: "2025-06-21",
      status: "Draft",
      assigned_to: @user,
      created_by: @user
    )
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "title should be present" do
    @task.title = ""
    assert_not @task.valid?
  end

  test "description should be present" do
    @task.description = nil
    assert_not @task.valid?
  end

  test "status should be present" do
    @task.status = nil
    assert_not @task.valid?
  end

  test "due_date should be present" do
    @task.due_date = nil
    assert_not @task.valid?
  end

  test "created_by should be present" do
    @task.created_by = nil
    assert_not @task.valid?
  end

  test "assigned_to should be optional" do
    @task.assigned_to = nil
    assert @task.valid?
  end

  test "assigned_by should be optional" do
    @task.assigned_by = nil
    assert @task.valid?
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

  test "task should not be overdue if due date is in the future" do
    task = Task.create!(
      title: "Future Task",
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
      title: "Invalid Task",
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
      title: "Valid Task",
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
