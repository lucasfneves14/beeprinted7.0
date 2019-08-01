class AddUnaprovedToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :unaproved, :boolean,:default => false
  end
end
