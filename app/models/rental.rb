class Rental < ActiveRecord::Base
  has_many :payments

  belongs_to :inventory
  belongs_to :customer
  belongs_to :staff

  validates :return_date, presence: true
end