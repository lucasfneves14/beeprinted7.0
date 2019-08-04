class AddModelerIdToRatings < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :modeler, foreign_key: true
  end
end
