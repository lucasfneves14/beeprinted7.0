class JobsController < ApplicationController
  before_action :authenticate_modeler!, raise: false
  before_action :admin, only: [:new, :create, :edit, :update, :destroy, :analisar, :aprovar]
  layout 'hives/navbar'
  before_action :set_job, only: [:show, :edit, :update, :destroy, :aceitar, :enviar, :associar, :aprovar]

  # GET /jobs
  # GET /jobs.json
  def index
    @disponiveis = Job.all.where(available: true)
    @aceitos = current_modeler.jobs.where(done: false).order('created_at DESC')
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.done = false
    @job.available = true
    if @job.save
      flash[:success] = "O job #{@job.title} foi criado!"
      JobCriadoMailer.job_criado(current_modeler, @job).deliver
      redirect_to @job
    else
      flash[:alert] = "O job #{@job.title} não pode ser salvo! Por favor, cheque o formulário."
      render :new
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    if @job.update(job_params)
      flash[:success] = "O job #{@job.title} foi editado com sucesso!"
      redirect_to @job
    else
      flash[:alert] = "O job #{@job.title} não pode ser editado! Por favor, cheque o formulário."
      render :edit
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    if @job.destroy
      flash[:success] = "O job #{@job.title} foi excluído com sucesso!"
      redirect_to jobs_path
    end
  end

  def aceitar
    @job.available = false
    @job.modeler_id = current_modeler.id
    if @job.save
      AceitouModelerMailer.aceitou_modeler(current_modeler, @job).deliver
      AceitouModelerMailer.aceitou_admin(current_modeler, @job).deliver
      flash[:success] = "Você aceitou o job #{@job.title} com sucesso!"
      redirect_to jobs_path
    else
      flash[:alert] = "Algo de errado ocorreu. Por favor, tente novamente!"
      render :show
    end
  end

  def enviar
    @jobmodel = Jobmodel.new
  end

  def associar
    array = params[:job][:array]
    array = array.split(",")
    array.each do |file|
      puts file
      if Jobmodel.where(id: file).any?
        jobmodel = Jobmodel.find(file)
        @job.jobmodels << jobmodel
      end
    end
    if @job.jobmodels.any?
      AceitouModelerMailer.enviou_admin(current_modeler, @job).deliver
      AceitouModelerMailer.enviou_modeler(current_modeler, @job).deliver
      flash[:success] = "Arquivos enviados com sucesso!"
      redirect_to jobs_path
    end
  end

  def analisar
    @analisados = Job.includes(:jobmodels).where(available: false, done: false).where.not(jobmodels: {job_id: nil})
  end

  def aprovar
    @job.done = true
    if @job.save
      AceitouModelerMailer.aprovou_admin(current_modeler, @job).deliver
      AceitouModelerMailer.aprovou_modeler(current_modeler, @job).deliver
      flash[:success] = "Job Aprovado!"
      redirect_to jobs_path
    else
      flash[:success] = "Algo de errado ocorreu! Por favor, tente novamente"
      redirect_to job_path(@job)
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def admin
      unless current_modeler.admin
        flash[:alert] = "Acesso negado!"
        redirect_to jobs_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description,:image, :x, :y, :z, :tipo, :value, :observations, :array)
    end
end
