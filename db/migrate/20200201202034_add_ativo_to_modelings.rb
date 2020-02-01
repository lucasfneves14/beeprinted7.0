class AddAtivoToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :ativo, :boolean, :default => true
  end
end
