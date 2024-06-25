class TaskQuery
  attr_reader :params, :tasks

  def initialize(params = {}, tasks = Task.all, user = nil)
    @params = params
    @tasks = tasks
    @user = user
  end

  def call
    tasks = @tasks
    tasks = apply_user_filters(tasks)
    tasks = apply_general_filters(tasks)
    tasks
  end

  private

  def apply_user_filters(tasks)
    tasks = tasks.assigned_to_or_assigned_by_or_created_by(@user)
    tasks
  end

  def apply_general_filters(tasks)
    tasks = tasks.where(status: @params[:status]) if @params[:status].present?
    if @params[:sort].present? && allowed_sort_columns.include?(@params[:sort])
      order = @params[:order] == 'desc' ? 'desc' : 'asc'
      tasks = tasks.order("#{@params[:sort]} #{order}")
    end
    tasks
  end

  def allowed_sort_columns
    %w[due_date status]
  end
end
