class AddIdentificadorToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :identificador, :integer
  end
end
