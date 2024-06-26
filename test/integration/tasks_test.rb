require 'test_helper'

class TasksTest < ActionDispatch::IntegrationTest
  def setup
    @task1 = tasks(:one)
    @task2 = tasks(:two)

    @user = users(:one)
    @other_user = users(:two)
    sign_in @user
  end

  test "should not allow unauthorized access" do
    sign_out @user
    get task_url(@task1)
    assert_redirected_to new_user_session_path

    sign_in @other_user
    get edit_task_url(@task1)
    assert_redirected_to root_path
  end

  test "should allow authorized access for user with task assigned to it" do
    sign_out @user
    sign_in @other_user
    get task_url(@task2)
    assert_response :success
  end

  test "should create task with all attributes" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: {
        title: "New Task",
        description: "Task description",
        due_date: "2025-06-21",
        status: :draft,
        assigned_to_id: @user.id,
        assigned_by_id: @user.id,
        created_by_id: @user.id
      } }
    end

    task = Task.last
    assert_equal "New Task", task.title
    assert_equal "Task description", task.description
    assert_equal "2025-06-21", task.due_date.to_s
    assert_equal "draft", task.status
    assert_equal @user.id, task.assigned_to_id
    assert_equal @user.id, task.assigned_by_id
    assert_equal @user.id, task.created_by_id
    assert_redirected_to task_url(task)
  end

  test "should filter tasks by invalid status" do
    get tasks_url, params: { status: 'NonExistentStatus' }
    assert_response :success
    assert_select 'tbody tr', count: 0
  end

  test "should sort tasks by invalid parameter" do
    get tasks_url, params: { sort: 'invalid_sort' }
    assert_response :success
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
      post tasks_url, params: { task: {
        title: @task1.title,
        description: @task1.description,
        due_date: "2025-06-21",
        status: :draft,
      } }
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
    patch task_url(@task1), params: { task: { title: "Updated title" } }
    assert_redirected_to task_url(@task1)
    @task1.reload
    assert_equal "Updated title", @task1.title
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task1)
    end

    assert_redirected_to tasks_url
  end

  test "should filter tasks by status" do
    get tasks_url, params: { status: :draft }
    assert_response :success
    assert_select 'tbody tr', count: 1
  end

  test "should sort tasks by due date in descending order" do
    get tasks_url, params: { sort: 'due_date', order: 'asc' }
    assert_response :success
    assert_select 'tbody tr:first-child td', text: @task2.title
  end

  test "should sort tasks by due date in ascending order" do
    get tasks_url, params: { sort: 'due_date', order: 'desc' }
    assert_response :success
    assert_select 'tbody tr:first-child td', text: @task1.title
  end

  test "should sort tasks by status" do
    get tasks_url, params: { sort: 'status', order: 'asc' }
    assert_response :success
    assert_select 'tbody tr:first-child td', text: @task1.title
  end
end
