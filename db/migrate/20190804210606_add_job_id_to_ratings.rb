class AddJobIdToRatings < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :job, foreign_key: true
  end
end
