class AddImageToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :image, :string
  end
end
