class CreateServicos < ActiveRecord::Migration[5.2]
  def change
    create_table :servicos do |t|
      t.float :valor_unit
      t.integer :quantidade
      t.float :valor
      t.integer :prazo

      t.timestamps
    end
  end
end
