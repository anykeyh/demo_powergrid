class Country < ActiveRecord::Base
  validates :country, presence: true

  has_many :cities

  def name
    country
  end
end