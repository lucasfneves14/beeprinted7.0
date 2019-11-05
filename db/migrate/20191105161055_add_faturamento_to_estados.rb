class AddFaturamentoToEstados < ActiveRecord::Migration[5.2]
  def change
    add_column :estados, :faturamento, :float
  end
end
