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
end
