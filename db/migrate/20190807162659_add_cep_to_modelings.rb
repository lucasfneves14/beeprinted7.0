class AddCepToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :cep, :string
  end
end
