class ChangeDadosFromServicos < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :servicos, :quantidade, 1
  end
end
