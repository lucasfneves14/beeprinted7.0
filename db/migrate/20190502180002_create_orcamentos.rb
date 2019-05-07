class CreateOrcamentos < ActiveRecord::Migration[5.2]
  def change
    create_table :orcamentos do |t|
      t.string :description

      t.timestamps
    end
  end
end
