class AddDescontoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :desconto, :integer, :default => 0
  end
end
