class AddTelefoneToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :telefone, :string
  end
end
