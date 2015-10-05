class Address < ActiveRecord::Base
  validates :address, presence: true
  validates :postal_code, presence: true

  has_many :customers
  has_many :staffs

  belongs_to :city
end