class GraphicsController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :admin
  layout 'system/navbar'
  def index
  	@group = params[:group]
  	@orcamentos = Orcamento.where.not(status: "Cancelado")
	@modelagens = Modeling.where.not(status: "Cancelado")
	@adicionados = Adicionado.where.not(status: "Cancelado")

	@planilha = (@modelagens + @orcamentos + @adicionados)
	@iago = @planilha.select{|orcamento| orcamento.responsavel == "Iago"}
	@thierre = @planilha.select{|orcamento| orcamento.responsavel == "Thierre"}
	if @group == "dia" || @group == nil
		@iago = @iago.group_by_day {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
		@thierre = @thierre.group_by_day {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
		@planilha = @planilha.group_by_day {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
	elsif @group == "semana"
		@iago = @iago.group_by_week {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
		@thierre = @thierre.group_by_week {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
		@planilha = @planilha.group_by_week {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
	elsif @group == "mes"
		@iago = @iago.group_by_month {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
		@thierre = @thierre.group_by_month {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
		@planilha = @planilha.group_by_month {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
	end
  end

  private

  def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
