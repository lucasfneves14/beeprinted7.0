class AddTipoToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :tipo, :string
    add_column :jobs, :done, :boolean
    add_column :jobs, :available, :boolean
  end
end
