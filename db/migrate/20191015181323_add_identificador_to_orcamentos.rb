class AddIdentificadorToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :identificador, :integer
  end
end
