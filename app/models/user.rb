class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  mount_uploader :avatar, AvatarUploader


  has_many :posts, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :orcamentos, dependent: :destroy
  has_many :modelings, dependent: :destroy
  has_many :adicionados, dependent: :destroy

  validates :sobrenome, presence: true
  validates :name, presence: true
  validates :email, presence: true

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      #user.email = auth.info.email
      user.name = auth.extra.raw_info.first_name
      user.sobrenome = auth.extra.raw_info.last_name
      user.uid = auth.uid
      user.provider = auth.provider
      user.password = Devise.friendly_token[0,20]
    end
    return user
  end


end
