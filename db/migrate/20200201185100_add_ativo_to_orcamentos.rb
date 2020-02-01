class AddAtivoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :ativo, :boolean, :default => true
  end
end
