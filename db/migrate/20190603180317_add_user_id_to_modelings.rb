class AddUserIdToModelings < ActiveRecord::Migration[5.2]
  def change
    add_reference :modelings, :user, foreign_key: true
  end
end
