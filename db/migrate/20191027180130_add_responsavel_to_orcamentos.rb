class AddResponsavelToOrcamentos < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :responsavel, :string
  end
end
