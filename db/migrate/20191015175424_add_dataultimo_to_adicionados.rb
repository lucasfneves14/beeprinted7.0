class AddDataultimoToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :dataultimo, :string, :default => "-"
  end
end
