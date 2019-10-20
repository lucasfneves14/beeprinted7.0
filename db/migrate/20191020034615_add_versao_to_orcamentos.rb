class AddVersaoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :versao, :string
  end
end
