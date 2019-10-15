class AddDataretornoToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :dataretorno, :string, :default => "-"
  end
end
