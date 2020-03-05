class AddAvaliacaoTxtToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :avaliacao_txt, :text
  end
end
