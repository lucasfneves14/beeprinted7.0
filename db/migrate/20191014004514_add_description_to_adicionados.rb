class AddDescriptionToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :description, :string
  end
end
