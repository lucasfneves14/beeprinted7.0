class AddUserIdToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_reference :adicionados, :user, foreign_key: true
  end
end
