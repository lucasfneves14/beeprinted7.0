class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.text :comentario
      t.integer :value

      t.timestamps
    end
  end
end
