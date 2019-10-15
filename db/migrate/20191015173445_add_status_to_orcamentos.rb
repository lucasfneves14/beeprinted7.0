class AddStatusToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :status, :string, :default => "New"
  end
end
