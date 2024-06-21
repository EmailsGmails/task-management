require 'test_helper'

class TasksTest < ActionDispatch::IntegrationTest
  def setup
    @task1 = tasks(:one)
    @task2 = tasks(:two)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: @task1.name, description: @task1.description } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test "should show task" do
    get task_url(@task1)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task1)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task1), params: { task: { name: "Updated Name" } }
    assert_redirected_to task_url(@task1)
    @task1.reload
    assert_equal "Updated Name", @task1.name
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task1)
    end

    assert_redirected_to tasks_url
  end

  test "should filter tasks by status" do
    get tasks_url, params: { status: 'Draft' }
    assert_response :success
    assert_select 'tbody tr', count: 1
  end

  test "should sort tasks by due date" do
    get tasks_url, params: { sort: 'due_date' }
    assert_response :success
    assert_select 'tbody tr:first-child td', text: @task2.name
  end

  test "should sort tasks by status" do
    get tasks_url, params: { sort: 'status' }
    assert_response :success
    assert_select 'tbody tr:first-child td', text: @task1.name
  end

end
