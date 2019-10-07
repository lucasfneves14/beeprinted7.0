class AddSobrenomeToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :sobrenome, :string
  end
end
