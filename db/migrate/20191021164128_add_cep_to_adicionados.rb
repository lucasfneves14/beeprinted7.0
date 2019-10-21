class AddCepToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :cep, :string
  end
end
