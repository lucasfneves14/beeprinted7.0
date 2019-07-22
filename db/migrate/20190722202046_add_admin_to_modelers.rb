class AddAdminToModelers < ActiveRecord::Migration[5.2]
  def change
    add_column :modelers, :admin, :boolean, :default => false
  end
end
