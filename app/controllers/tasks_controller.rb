class TasksController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @tasks = Task.all
    @tasks = @tasks.with_status(params[:status]) if params[:status].present?
    @tasks = @tasks.order_by_due_date if params[:sort] == 'due_date'
    @tasks = @tasks.sort_by { |task| Task.statuses.keys.index(task.status) } if params[:sort] == 'status'
  end

  def new
    @task = Task.new
    @users = User.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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

  def complete
    @task.update(status: 'completed')
    redirect_to @task, notice: 'Task marked as completed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :status, :user_id)
  end
end
