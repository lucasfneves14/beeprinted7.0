class Modeler < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ModelerImageUploader


  has_many :jobs
  has_many :job_notification
  has_many :ratings

  validates :name, presence: true
  validates :email, presence: true
end
