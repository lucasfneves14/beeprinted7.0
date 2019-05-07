class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.string :url
      t.text :seo_meta
      t.string :seo_title
      t.string :attachment

      t.timestamps
    end
  end
end
