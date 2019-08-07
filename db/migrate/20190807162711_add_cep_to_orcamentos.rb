class AddCepToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :cep, :string
  end
end
