class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :due_date
      t.string :status
      t.references :user, polymorphic: true

      t.timestamps
    end
  end
end
