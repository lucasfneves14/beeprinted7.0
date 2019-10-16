class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :tempo
      t.integer :massa
      t.float :valor_unit
      t.integer :quantidade
      t.float :valor
      t.string :resolucao
      t.integer :infill
      t.string :cor
      t.string :material

      t.timestamps
    end
  end
end
