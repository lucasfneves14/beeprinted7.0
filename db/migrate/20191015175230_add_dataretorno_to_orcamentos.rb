class AddDataretornoToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :dataretorno, :string, :default => "-"
  end
end
