class VersionController < ApplicationController
  def create
  	@orcamento = Orcamento.includes(:arquivos).find_by(identificador: params[:id])
	if @orcamento == nil
		@orcamento = Modeling.find_by(identificador: params[:id])
		if @orcamento == nil
			@orcamento = Adicionado.find_by(identificador: params[:id])
		end
	end
  	num = @orcamento.class.unscoped.where(identificador: params[:id]).count
  	@new = @orcamento.amoeba_dup
  	@new.versao = (num + 97).chr

  	@orcamento.ativo = false
  	if @new.save
  		if @orcamento.save
  			redirect_to system_edit_path(@orcamento.identificador)
  		end
  	end
  end

  def principal
  	@orcamento = Orcamento.includes(:arquivos).find_by(identificador: params[:id])
	if @orcamento == nil
		@orcamento = Modeling.find_by(identificador: params[:id])
		if @orcamento == nil
			@orcamento = Adicionado.find_by(identificador: params[:id])
		end
	end

	@orcamento.ativo = false
	@principal = @orcamento.class.unscoped.where(identificador: params[:id]).find_by(versao: params[:versao])
	@principal.ativo = true
	if @orcamento.save
		if @principal.save
			redirect_to system_edit_path(@principal.identificador)
		end
	end
  end


end
