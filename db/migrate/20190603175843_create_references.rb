class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :attachment

      t.timestamps
    end
  end
end
