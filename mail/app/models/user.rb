class User < ApplicationRecord
  validates :name, :id_telegram, :email, presence: true
  validates :id_telegram, :email, uniqueness: true
  validates :email, email: true
end
