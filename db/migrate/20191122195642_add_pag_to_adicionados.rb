class AddPagToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :pag, :string, :default => "Único"
  end
end
