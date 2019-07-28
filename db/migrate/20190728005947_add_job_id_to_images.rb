class AddJobIdToImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :job, foreign_key: true
  end
end
