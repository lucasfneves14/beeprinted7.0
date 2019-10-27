class AddResponsavelToAdicionados < ActiveRecord::Migration[5.2]
  def change
    add_column :adicionados, :responsavel, :string
  end
end
