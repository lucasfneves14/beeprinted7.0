class RemovePrazoFromOrcamentos < ActiveRecord::Migration[5.2]
  def change
    remove_column :orcamentos, :prazo, :integer
  end
end
