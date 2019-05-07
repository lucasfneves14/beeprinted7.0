class CreateArquivos < ActiveRecord::Migration[5.2]
  def change
    create_table :arquivos do |t|
      t.string :attachment

      t.timestamps
    end
  end
end
