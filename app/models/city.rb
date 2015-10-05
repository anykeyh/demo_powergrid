class City < ActiveRecord::Base
  validates :city, presence: true
  belongs_to :country

  has_many :addresses

  def name
    city
  end
end