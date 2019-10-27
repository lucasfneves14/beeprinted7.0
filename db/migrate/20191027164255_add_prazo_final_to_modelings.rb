class AddPrazoFinalToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :prazo_final, :string
  end
end
