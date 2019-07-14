class AddCityToModelers < ActiveRecord::Migration[5.2]
  def change
    add_column :modelers, :city, :string
  end
end
