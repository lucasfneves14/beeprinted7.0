class CreateJobNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :job_notifications do |t|
      t.string :message

      t.timestamps
    end
  end
end
