class AddCanalToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :canal, :string
  end
end
