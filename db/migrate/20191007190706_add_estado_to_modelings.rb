class AddEstadoToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :estado, :string
    add_column :modelings, :empresa, :string
  end
end
