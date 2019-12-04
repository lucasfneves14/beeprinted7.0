class AddDescontoToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :desconto, :integer, :default => 0
  end
end
