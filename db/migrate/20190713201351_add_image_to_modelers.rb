class AddImageToModelers < ActiveRecord::Migration[5.2]
  def change
    add_column :modelers, :image, :string
  end
end
