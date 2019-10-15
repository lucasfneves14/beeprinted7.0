class AddStatusToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :status, :string, :default => "New"
  end
end
