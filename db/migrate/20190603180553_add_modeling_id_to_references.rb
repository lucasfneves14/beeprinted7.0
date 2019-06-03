class AddModelingIdToReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :references, :modeling, foreign_key: true
  end
end
