class JobsController < ApplicationController
  before_action :authenticate_modeler!, raise: false
  layout 'hives/navbar'
  before_action :set_job, only: [:show, :edit, :update, :destroy, :aceitar, :enviar, :associar]

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

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def aceitar
    @job.available = false
    @job.modeler_id = current_modeler.id
    if @job.save
      redirect_to jobs_path
    else
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
    redirect_to jobs_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description,:image, :x, :y, :z, :tipo, :value, :observations, :array)
    end
end
