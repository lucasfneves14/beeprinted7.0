class AddPropostaEnviadaToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :proposta_enviada, :boolean, :default => false
  end
end
