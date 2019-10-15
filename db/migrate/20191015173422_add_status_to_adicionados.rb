class AddStatusToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :status, :string, :default => "New"
  end
end
