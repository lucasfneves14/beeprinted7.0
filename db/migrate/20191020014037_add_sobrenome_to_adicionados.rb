class AddSobrenomeToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :sobrenome, :string
  end
end
