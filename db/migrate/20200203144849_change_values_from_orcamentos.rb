class ChangeValuesFromOrcamentos < ActiveRecord::Migration[5.2]
  def change
  	change_column :orcamentos, :frete, :float, :default => 0.0
  	change_column :orcamentos, :tempo_impressao, :float, :default => 0.0
  	change_column :orcamentos, :tempo_setup, :float, :default => 0.0
  	change_column :orcamentos, :prazo_orc, :integer, :default => 0
  	change_column :orcamentos, :prazo_desejado, :integer, :default => 0
  	change_column :orcamentos, :tempo_execucao, :integer, :default => 0.0

  	change_column :modelings, :frete, :float, :default => 0.0
  	change_column :modelings, :tempo_impressao, :float, :default => 0.0
  	change_column :modelings, :tempo_setup, :float, :default => 0.0
  	change_column :modelings, :prazo_orc, :integer, :default => 0
  	change_column :modelings, :prazo_desejado, :integer, :default => 0
  	change_column :modelings, :tempo_execucao, :integer, :default => 0.0

  	change_column :adicionados, :frete, :float, :default => 0.0
  	change_column :adicionados, :tempo_impressao, :float, :default => 0.0
  	change_column :adicionados, :tempo_setup, :float, :default => 0.0
  	change_column :adicionados, :prazo_orc, :integer, :default => 0
  	change_column :adicionados, :prazo_desejado, :integer, :default => 0
  	change_column :adicionados, :tempo_execucao, :integer, :default => 0.0
  end
end
