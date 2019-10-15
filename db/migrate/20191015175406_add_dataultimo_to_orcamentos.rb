class AddDataultimoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :dataultimo, :string, :default => "-"
  end
end
