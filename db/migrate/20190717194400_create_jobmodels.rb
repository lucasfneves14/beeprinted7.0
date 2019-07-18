class CreateJobmodels < ActiveRecord::Migration[5.2]
  def change
    create_table :jobmodels do |t|
      t.string :attachment

      t.timestamps
    end
  end
end
