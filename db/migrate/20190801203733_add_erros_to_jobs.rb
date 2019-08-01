class AddErrosToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :erros, :text
  end
end
