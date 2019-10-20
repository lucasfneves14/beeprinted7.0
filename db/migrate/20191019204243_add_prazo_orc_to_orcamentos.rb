class AddPrazoOrcToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :prazo_orc, :integer
  end
end
