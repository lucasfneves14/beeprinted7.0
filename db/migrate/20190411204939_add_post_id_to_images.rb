class AddPostIdToImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :post, foreign_key: true
  end
end
