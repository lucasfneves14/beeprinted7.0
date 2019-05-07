class AddOrcamentoIdToArquivos < ActiveRecord::Migration[5.2]
  def change
    add_reference :arquivos, :orcamento, foreign_key: true
  end
end
