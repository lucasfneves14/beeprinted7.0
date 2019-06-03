class AddTipoToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :prazo, :string
    add_column :modelings, :tipo, :string
  end
end
