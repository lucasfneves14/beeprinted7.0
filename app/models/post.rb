class Post < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :services

  validates :user_id, presence: true
  validates :caption, presence: true
  validates :images, presence: true
  attr_accessor :array
end
