class AddDataretornoToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :dataretorno, :string, :default => "-"
  end
end
