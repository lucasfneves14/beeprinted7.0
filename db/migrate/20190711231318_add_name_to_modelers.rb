class AddNameToModelers < ActiveRecord::Migration[5.2]
  def change
    add_column :modelers, :name, :string
  end
end
