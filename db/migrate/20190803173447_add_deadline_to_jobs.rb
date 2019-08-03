class AddDeadlineToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :deadline, :string
  end
end
