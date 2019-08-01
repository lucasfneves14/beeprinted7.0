class AddResumeToErros < ActiveRecord::Migration[5.2]
  def change
    add_column :erros, :resume, :string
  end
end
