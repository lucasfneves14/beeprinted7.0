class AddModelingIdToJobNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_notifications, :modeling, foreign_key: true
  end
end
