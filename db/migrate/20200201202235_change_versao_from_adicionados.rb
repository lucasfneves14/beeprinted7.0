class ChangeVersaoFromAdicionados < ActiveRecord::Migration[5.2]
  def change
  	change_column :adicionados, :versao, :string, :default => 'a'
  end
end
