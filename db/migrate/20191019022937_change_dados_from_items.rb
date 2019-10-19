class ChangeDadosFromItems < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :items, :quantidade, 1
  	change_column_default :items, :resolucao, "Normal"
  	change_column_default :items, :infill, 20
  	change_column_default :items, :cor, "Preto"
  	change_column_default :items, :material, "PLA"
  end
end
