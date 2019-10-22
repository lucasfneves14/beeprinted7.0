class AddSiglaToEstados < ActiveRecord::Migration[5.2]
  def change
    add_column :estados, :sigla, :string
  end
end
