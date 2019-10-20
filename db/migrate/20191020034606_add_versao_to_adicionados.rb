class AddVersaoToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :versao, :string
  end
end
