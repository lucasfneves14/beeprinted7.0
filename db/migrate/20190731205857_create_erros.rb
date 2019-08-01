class CreateErros < ActiveRecord::Migration[5.2]
  def change
    create_table :erros do |t|
      t.string :title
      t.string :url
      t.text :summary
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end
