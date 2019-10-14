class CreateAdicionados < ActiveRecord::Migration[5.2]
  def change
    create_table :adicionados do |t|
      t.string :name
      t.string :canal
      t.string :email
      t.string :telefone
      t.string :estado
      t.string :empresa
      t.string :descricao
      t.string :data

      t.timestamps
    end
  end
end
