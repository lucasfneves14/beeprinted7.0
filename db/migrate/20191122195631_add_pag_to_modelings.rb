class AddPagToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :pag, :string, :default => "Único"
  end
end
