class AddAvaliacaoTxtToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :avaliacao_txt, :text
  end
end
