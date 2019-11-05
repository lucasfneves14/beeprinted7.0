class OrcamentosController < ApplicationController
  require 'json'
  before_action :set_orcamento, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!, raise: false, only:[:new, :create,:edit,:update]

  # GET /orcamentos
  # GET /orcamentos.json

  def sucesso
  end

  def index
    @orcamentos = Orcamento.all
  end

  # GET /orcamentos/1
  # GET /orcamentos/1.json
  def show
  end

  # GET /orcamentos/new
  def new
    @orcamento = Orcamento.new
    @arquivo = Arquivo.new
    @modeling = Modeling.new
    @reference = Reference.new
    if current_user
      @orcamento.name = "#{current_user.name}"
      @orcamento.sobrenome = "#{current_user.sobrenome}"
      @modeling.name = "#{current_user.name}"
      @modeling.sobrenome = "#{current_user.sobrenome}"
      @orcamento.email = current_user.email
      @modeling.email = current_user.email
    end

  end

  # GET /orcamentos/1/edit
  def edit
  end

  # POST /orcamentos
  # POST /orcamentos.json
  def create
    @orcamento = Orcamento.create(orcamento_params)


    @mes = Date.today.strftime("%m")
    @ano = Date.today.strftime("%Y")

    @orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes)
    @modelagens = Modeling.where('extract(month  from created_at) = ?', @mes)
    @adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes)
    @planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.created_at <=> b.created_at }

    identificador = (@ano.to_i*100 + @mes.to_i)*1000 + @planilha.count + 1

    @orcamento.identificador = identificador
    @orcamento.responsavel = "Thierre"
    @orcamento.canal = "Upload"

    #@client = ::Pipedrive::Person.new
    #bla = RestClient.get('https://beeprinted-981d36.pipedrive.com/v1/persons/find?api_token=3b5b5a35e9fe27d0d10b21d8a2d004ab0efa91d3', :params => {term: @orcamento.email, search_by_email: 1})
    #bla = JSON.parse bla.body
    #if bla["data"]
    #  @id = bla["data"].first["id"]
    #else
    #  @client = @client.create(name: @orcamento.name, email: @orcamento.email, 'a397d8273b813ca4a92514490706109ddc08460e' => @orcamento.cep, label: 4)
    #  @client = @client.data
    #  @id = @client.id
    #end

    #deal = ::Pipedrive::Deal.new
    #@deal = deal.create(person_id: @id, title: "Negócio #{@orcamento.name} Teste")
    #@deal = @deal.data

    #@anterior = deal.find_by_id(@deal.id-1)
    #@anterior = @anterior.data
    #codigo = @anterior.title
    #codigo = codigo[/\((.*?)\)/, 1]
    #puts 'BBBBBBBBBBBBBBBBBBBBBB'
    #puts codigo


    array = @orcamento.array.split(",")
    array.each do |file|
      if Arquivo.where(id: file).any?
        arquivo = Arquivo.find(file)
        @orcamento.arquivos << arquivo
      end
    end

    #@orcamento.arquivos.each do |arquivo|
    #  bla = RestClient.post('https://beeprinted-981d36.pipedrive.com/v1/files?api_token=3b5b5a35e9fe27d0d10b21d8a2d004ab0efa91d3', 
    #    :file => File.open("#{ Rails.env.development? ? 'public' : '' }#{arquivo.attachment.url}"), deal_id: @deal.id)
    #end

    if @orcamento.save
      OrcamentoMailer.orcamento_email(@orcamento, current_visit).deliver
      flash[:success] = "Seu pedido de orçamento foi enviado! Em breve, responderemos por email."
      redirect_to orcamento_sucesso_path
    else
      if @orcamento.arquivos.any?
        flash[:alert] = "Seu pedido de orçamento não pode ser salvo! Por favor, cheque o formulário."
      else
        flash[:alert] = "Seu pedido de orçamento não pode ser salvo! Nenhum arquivo foi enviado ou houve um erro no envio dos arquivos."
      end
      @arquivo = Arquivo.new
      @reference = Reference.new
      @modeling = Modeling.new
      @orcamento_check = 1
      render :new
    end
  end

  # PATCH/PUT /orcamentos/1
  # PATCH/PUT /orcamentos/1.json
  def update
    respond_to do |format|
      if @orcamento.update(orcamento_params)
        format.html { redirect_to @orcamento, notice: 'Orcamento was successfully updated.' }
        format.json { render :show, status: :ok, location: @orcamento }
      else
        format.html { render :edit }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orcamentos/1
  # DELETE /orcamentos/1.json
  def destroy
    @orcamento.destroy
    respond_to do |format|
      format.html { redirect_to orcamentos_url, notice: 'Orcamento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orcamento
      @orcamento = Orcamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orcamento_params
      params.require(:orcamento).permit(:description, :array, :name, :sobrenome, :estado, :empresa, :telefone, :email, :cep)
    end
end
