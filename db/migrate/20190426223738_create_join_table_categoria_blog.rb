class CreateJoinTableCategoriaBlog < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categoria, :blogs do |t|
      # t.index [:categorium_id, :blog_id]
      # t.index [:blog_id, :categorium_id]
    end
  end
end
