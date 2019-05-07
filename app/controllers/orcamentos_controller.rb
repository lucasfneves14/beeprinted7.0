class OrcamentosController < ApplicationController
  before_action :set_orcamento, only: [:show, :edit, :update, :destroy]

  # GET /orcamentos
  # GET /orcamentos.json
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

  end

  # GET /orcamentos/1/edit
  def edit
  end

  # POST /orcamentos
  # POST /orcamentos.json
  def create
    @orcamento = Orcamento.create(orcamento_params)
    array = @orcamento.array.split(",")
    array.each do |file|
      puts file
      if Arquivo.where(id: file).any?
        arquivo = Arquivo.find(file)
        @orcamento.arquivos << arquivo
      end
    end
    @user = current_user
    if @orcamento.save
      OrcamentoMailer.orcamento_email(@user, @orcamento).deliver
      flash[:success] = "Seu pedido de orçamento foi enviado! Em breve, responderemos por email."
      redirect_to root_path
    else
      flash[:alert] = "Seu pedido de orçamento não pode ser salvo! Por favor, cheque o formulário."
      @arquivo = Arquivo.new
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
      params.require(:orcamento).permit(:description, :array)
    end
end
