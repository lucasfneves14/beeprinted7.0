class AddAvaliacaoToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :avaliacao, :integer
  end
end
