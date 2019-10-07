class AddSobrenomeToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :sobrenome, :string
  end
end
