class AddAvaliacaoToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :avaliacao, :integer
  end
end
