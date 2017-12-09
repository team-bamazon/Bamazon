class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :cart
  has_many :orders
  has_many :payment_informations
  has_many :wanteds
  has_many :reviews
  has_many :review_comments
  has_many :dislikes
  has_many :likes
  accepts_nested_attributes_for :payment_informations
  has_many :addresses
end
