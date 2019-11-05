class AddCanalToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :canal, :string
  end
end
