class CreateJoinTableServicePost < ActiveRecord::Migration[5.2]
  def change
    create_join_table :services, :posts do |t|
      # t.index [:service_id, :post_id]
      # t.index [:post_id, :service_id]
    end
  end
end
