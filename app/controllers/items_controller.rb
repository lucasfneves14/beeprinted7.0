class ItemsController < ApplicationController
	def create
  	@item = Item.create(item_params)
  	if @item.attachment != nil
  		string = File.basename(@item.attachment.url)
		  @item.name = CGI.unescape(string)
      #fatiador params[:item][:attachment]
	  end
    
    #file = ::Pipedrive::File.new
    #@file = file.create(file: params[:arquivo][:attachment])
    #puts @arquivo.attachment.url
    #puts @arquivo.attachment
    #puts params[:arquivo][:attachment]
    #puts @file
  	if @item.save

  		render json: { message: "success", fileID: @item.id, filename: File.basename(@item.attachment.path)}, :status => 200
    else
    	render json: { error: "Um ERRO ocorreu! Por favor, entre em contato em contato@beeprinted.com.br"}, :status => 400
    end

  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      respond_to do |format|  
        format.json {render json: { message: "Arquivo deletado do servidor!" }}
      end
    else
      render json: { message: @item.errors.full_messages.join(',') }
    end
  end



private





def fatiador peca
    #puts current_path
    #./CuraEngine slice -v -s line_width=0.4 -j bee.def.json -o drogonsemsupport.gcode -l drogon-from-game-of-thrones-1.stl -s center_object=True

    name ||= "#{peca.path}"

    if Rails.env.production?
      output = `/home/ubuntu/CuraEngine/build/./CuraEngine slice -v -s line_width=0.4 -s infill_support_enabled=true -s infill_support_angle=50 -j ~/CuraEngine/build/bee.def.json -l #{name} -s center_object=True 2>&1` ; result=$?.success?

      ##{current_path} --layer-height 0.2 --support-material --fill-density 20 --nozzle-diameter 0.4 --filament-diameter 1.75 --support-material-angle 50 --fill-pattern rectilinear`
    

      puts 'OUTPUT:'
      puts output
      puts 'Result:'
      puts result

      filament = "Filament used (mm^3): "
      time = "Print time (s): "

    else

      output = `~/CuraEngine/build/./CuraEngine slice -v -s line_width=0.4 -s infill_support_enabled=true -s infill_support_angle=50 -j ~/CuraEngine/build/bee.def.json -l #{name} -s center_object=True 2>&1` ; result=$?.success?

      ##{current_path} --layer-height 0.2 --support-material --fill-density 20 --nozzle-diameter 0.4 --filament-diameter 1.75 --support-material-angle 50 --fill-pattern rectilinear`
    

      puts 'OUTPUT:'
      puts output
      puts 'Result:'
      puts result

      filament = "Filament: "
      time = "Print time: "

  end

    medida = output[/#{filament}(.*?)m/m, 1]
    puts "Peso Inicial: #{medida}"
    mednum = medida.to_f
    puts mednum
    peso = (mednum/1000)*1.24
    puts "Peso Calculado: #{peso}g"




    medida = output[/#{time}(.*?)m/m, 1]
    puts "Tempo Inicial: #{medida}"
    mednum = medida.to_f
    puts mednum
    tempo = mednum/60
    puts "Tempo Calculado: #{tempo} min"




    preco = tempo*0.24 + peso*0.28
    puts "Preco: R$ #{preco}"

  end






def item_params
	params.require(:item).permit(:attachment)
end
end
