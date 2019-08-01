class AddSeoToErros < ActiveRecord::Migration[5.2]
  def change
    add_column :erros, :seo_title, :string
    add_column :erros, :seo_meta, :string
  end
end
