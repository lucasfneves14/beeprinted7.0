class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(user, orcamento)
    @user = user
    @orcamento = orcamento
    OrcamentoMailer.orcamento_email(@user, @orcamento).deliver
  end
end
