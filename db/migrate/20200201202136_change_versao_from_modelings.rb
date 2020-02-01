class ChangeVersaoFromModelings < ActiveRecord::Migration[5.2]
  def change
  	change_column :modelings, :versao, :string, :default => 'a'
  end
end
