class AddSobrenomeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sobrenome, :string
  end
end
