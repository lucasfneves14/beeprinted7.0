class AddNameToServicos < ActiveRecord::Migration[5.2]
  def change
    add_column :servicos, :name, :string
  end
end
