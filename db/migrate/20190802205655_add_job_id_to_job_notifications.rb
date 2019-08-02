class AddJobIdToJobNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_notifications, :job, foreign_key: true
  end
end
