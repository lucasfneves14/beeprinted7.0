class CreateEstados < ActiveRecord::Migration[5.2]
  def change
    create_table :estados do |t|
      t.string :name
      t.integer :fechado
      t.integer :pedido
      t.float :conversao

      t.timestamps
    end
  end
end
