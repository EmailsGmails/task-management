class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = policy_scope(Task)
    @tasks = TaskQuery.new(query_params, Task.all, current_user).call.paginate(page: params[:page], per_page: 10)
  end

  def new
    @task = Task.new
    authorize @task
    @users = User.all
  end

  def create
    @task = Task.new(task_params)
    @task.created_by = current_user
    @task.assigned_by = current_user
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    @task.assigned_by = current_user
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
    authorize @task
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :assigned_to_id, :assigned_by_id, :created_by_id)
  end

  def query_params
    params.permit(:status, :sort, :order)
  end

end
