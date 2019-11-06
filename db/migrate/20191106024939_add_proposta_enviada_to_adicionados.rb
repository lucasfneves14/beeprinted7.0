class AddPropostaEnviadaToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :proposta_enviada, :boolean, :default => false
  end
end
