class ModelingsController < ApplicationController
	#before_action :authenticate_user!, raise: false, only:[:create]

  def sucesso
  end

  def create
  	@modeling = Modeling.create(modeling_params)
    array = @modeling.array.split(",")
    array.each do |file|
      puts file
      if Reference.where(id: file).any?
        reference = Reference.find(file)
        @modeling.references << reference
      end
    end
    if @modeling.save
      ModelingMailer.modeling_email(@modeling).deliver
      flash[:success] = "Seu pedido de orçamento foi enviado! Em breve, responderemos por email."
      redirect_to modeling_sucesso_path
    else
      flash[:alert] = "Seu pedido de orçamento não pode ser salvo! Por favor, cheque o formulário."
      @reference = Reference.new
      @arquivo = Arquivo.new
      @orcamento = Orcamento.new
      @modelagem_check =1
      render 'orcamentos/new'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modeling
      @modeling = Modeling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modeling_params
      params.require(:modeling).permit(:description, :tipo, :prazo, :array, :name, :email, :cep)
    end



end
