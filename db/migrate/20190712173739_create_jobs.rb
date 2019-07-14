class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.float :x
      t.float :y
      t.float :z
      t.string :type
      t.integer :value
      t.text :observations

      t.timestamps
    end
  end
end
