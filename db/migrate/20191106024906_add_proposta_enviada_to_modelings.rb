class AddPropostaEnviadaToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :proposta_enviada, :boolean, :default => false
  end
end
