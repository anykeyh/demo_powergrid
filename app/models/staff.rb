class Staff < ActiveRecord::Base
  has_one :managed_store, foreign_key: :manager_staff_id, :class_name => "Store"

  has_many :payments
  has_many :rentals

  belongs_to :address
  belongs_to :store

  validates :username, presence: true
  validates :password, presence: true
end