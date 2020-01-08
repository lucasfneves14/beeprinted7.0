class AddAttachmentToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :attachment, :string
  end
end
