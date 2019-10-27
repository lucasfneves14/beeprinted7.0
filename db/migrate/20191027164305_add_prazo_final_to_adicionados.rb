class AddPrazoFinalToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :prazo_final, :string
  end
end
