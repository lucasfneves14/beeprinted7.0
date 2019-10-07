class AddEstadoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :estado, :string
    add_column :orcamentos, :empresa, :string
  end
end
