class AddPrazoFinalToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :prazo_final, :string
  end
end
