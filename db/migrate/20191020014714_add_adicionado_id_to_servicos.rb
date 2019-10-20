class AddAdicionadoIdToServicos < ActiveRecord::Migration[5.2]
  def change
    add_reference :servicos, :adicionado, foreign_key: true
  end
end
