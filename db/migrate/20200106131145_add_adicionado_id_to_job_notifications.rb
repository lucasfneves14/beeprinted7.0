class AddAdicionadoIdToJobNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_notifications, :adicionado, foreign_key: true
  end
end
