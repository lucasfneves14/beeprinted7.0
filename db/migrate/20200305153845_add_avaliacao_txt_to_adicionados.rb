class AddAvaliacaoTxtToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :avaliacao_txt, :text
  end
end
