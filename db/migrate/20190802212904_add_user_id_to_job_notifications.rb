class AddUserIdToJobNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_notifications, :user, foreign_key: true
  end
end
