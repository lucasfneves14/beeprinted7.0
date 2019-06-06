class AddNameToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :name, :string
    add_column :orcamentos, :email, :string
  end
end
