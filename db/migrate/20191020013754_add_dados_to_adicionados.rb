class AddDadosToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :tempo_impressao, :float
    add_column :adicionados, :tempo_setup, :float
    add_column :adicionados, :frete, :float
    add_column :adicionados, :prazo_orc, :integer
    add_column :adicionados, :prazo_desejado, :integer
    add_column :adicionados, :tempo_execucao, :integer
    add_column :adicionados, :valor, :float
  end
end
