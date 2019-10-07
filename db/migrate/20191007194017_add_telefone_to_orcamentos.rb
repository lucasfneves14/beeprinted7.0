class AddTelefoneToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :telefone, :string
  end
end
