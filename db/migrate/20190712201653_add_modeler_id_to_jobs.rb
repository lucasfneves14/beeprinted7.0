class AddModelerIdToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :modeler, foreign_key: true
  end
end
