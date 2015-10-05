class Actor < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :film_actors
  has_many :films, :through => :film_actors
end