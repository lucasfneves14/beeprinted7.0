class AddDescontoToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :desconto, :integer, :default => 0
  end
end
