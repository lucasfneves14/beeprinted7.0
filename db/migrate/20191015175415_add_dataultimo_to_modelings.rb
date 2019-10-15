class AddDataultimoToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :dataultimo, :string, :default => "-"
  end
end
