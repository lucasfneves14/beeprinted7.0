class AddAdicionadoIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :adicionado, foreign_key: true
  end
end
