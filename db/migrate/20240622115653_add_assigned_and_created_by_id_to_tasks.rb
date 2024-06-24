class AddAssignedAndCreatedByIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :created_by_id, :integer
    add_column :tasks, :assigned_by_id, :integer

    rename_column :tasks, :user_id, :assigned_to_id
  end
end
