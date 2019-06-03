class CreateModelings < ActiveRecord::Migration[5.2]
  def change
    create_table :modelings do |t|
      t.text :description

      t.timestamps
    end
  end
end
