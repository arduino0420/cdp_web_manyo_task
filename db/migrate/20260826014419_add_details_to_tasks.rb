class AddDetailsToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :deadline_on, :date, null: false, default: Date.current
    add_column :tasks, :priority, :integer, null: false, default: 0
    add_column :tasks, :status, :integer, null: false, default: 0

    change_column_default :tasks, :deadline_on, from: Date.current, to: nil
    change_column_default :tasks, :priority, from: 0, to: nil
    change_column_default :tasks, :status, from: 0, to: nil
  end
end