class AddResponsavelToModelings < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :responsavel, :string
  end
end
