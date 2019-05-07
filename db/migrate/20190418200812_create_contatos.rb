class CreateContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :contatos do |t|
      t.string :name
      t.string :email
      t.string :mensagem

      t.timestamps
    end
  end
end
