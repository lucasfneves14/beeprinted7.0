class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader


  has_many :posts, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :orcamentos, dependent: :destroy

  validates :sobrenome, presence: true
  validates :name, presence: true
  validates :email, presence: true
end
