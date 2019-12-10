class ModelingsController < ApplicationController
	#before_action :authenticate_user!, raise: false, only:[:create]

  def new
    @modeling = Modeling.new
    @reference = Reference.new
    if current_user
      @modeling.name = "#{current_user.name}"
      @modeling.sobrenome = "#{current_user.sobrenome}"
      @modeling.email = current_user.email
    end

  end


  def sucesso
  end

  def create
  	@modeling = Modeling.create(modeling_params)

    @mes = Date.today.strftime("%m")
    @ano = Date.today.strftime("%Y")

    @orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes)
    @modelagens = Modeling.where('extract(month  from created_at) = ?', @mes)
    @adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes)
    @planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.created_at <=> b.created_at }

    identificador = (@ano.to_i*100 + @mes.to_i)*1000 + @planilha.count

    @modeling.identificador = identificador
    @modeling.responsavel = "Iago"
    @modeling.canal = "Modelagem"




    array = @modeling.array.split(",")
    array.each do |file|
      puts file
      if Reference.where(id: file).any?
        reference = Reference.find(file)
        @modeling.references << reference
      end
    end
    if @modeling.save
      ModelingMailer.modeling_email(@modeling, current_visit).deliver
      flash[:success] = "Seu pedido de orçamento foi enviado! Em breve, responderemos por email."
      redirect_to modeling_sucesso_path
    else
      flash[:alert] = "Seu pedido de orçamento não pode ser salvo! Por favor, cheque o formulário."
      @reference = Reference.new
      @arquivo = Arquivo.new
      @orcamento = Orcamento.new
      @modelagem_check =1
      render 'modelings/new'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modeling
      @modeling = Modeling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modeling_params
      params.require(:modeling).permit(:description, :tipo, :prazo, :array, :name, :sobrenome, :estado, :empresa, :telefone, :email, :cep)
    end



end
