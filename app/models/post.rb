class Post < ApplicationRecord
  has_many :images, dependent: :destroy
  validates :caption, presence: true
  validates :images, presence: true
  attr_accessor :array
end
