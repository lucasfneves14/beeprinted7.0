class AddPagToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :pag, :string, :default => "Único"
  end
end
