class AddOrcamentoIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :orcamento, foreign_key: true
  end
end
