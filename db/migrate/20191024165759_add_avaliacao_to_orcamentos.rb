class AddAvaliacaoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :avaliacao, :integer
  end
end
