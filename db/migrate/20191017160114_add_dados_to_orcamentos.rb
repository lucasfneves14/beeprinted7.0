class AddDadosToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :tempo_impressao, :float
    add_column :orcamentos, :tempo_setup, :float
    add_column :orcamentos, :frete, :float
    add_column :orcamentos, :prazo, :integer
    add_column :orcamentos, :prazo_desejado, :integer
    add_column :orcamentos, :tempo_execucao, :integer
    add_column :orcamentos, :valor, :float
  end
end
