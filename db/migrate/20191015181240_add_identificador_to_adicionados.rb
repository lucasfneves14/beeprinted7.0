class AddIdentificadorToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :identificador, :integer
  end
end
