class AddModelingIdToServicos < ActiveRecord::Migration[5.2]
  def change
    add_reference :servicos, :modeling, foreign_key: true
    add_reference :servicos, :orcamento, foreign_key: true
  end
end
