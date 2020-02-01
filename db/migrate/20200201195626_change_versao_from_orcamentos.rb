class ChangeVersaoFromOrcamentos < ActiveRecord::Migration[5.2]
  def change
  	change_column :orcamentos, :versao, :string, :default => 'a'
  end
end
