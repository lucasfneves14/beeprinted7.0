class AddOrcamentoIdToJobNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_notifications, :orcamento, foreign_key: true
  end
end
