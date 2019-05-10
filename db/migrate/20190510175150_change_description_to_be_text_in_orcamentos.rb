class ChangeDescriptionToBeTextInOrcamentos < ActiveRecord::Migration[5.2]
  def change
  	change_column :orcamentos, :description, :text
  end
end
