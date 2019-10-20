class AddDadosToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :tempo_impressao, :float
    add_column :modelings, :tempo_setup, :float
    add_column :modelings, :frete, :float
    add_column :modelings, :prazo_orc, :integer
    add_column :modelings, :prazo_desejado, :integer
    add_column :modelings, :tempo_execucao, :integer
    add_column :modelings, :valor, :float
  end
end
