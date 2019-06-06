class AddNameToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :name, :string
    add_column :modelings, :email, :string
  end
end
