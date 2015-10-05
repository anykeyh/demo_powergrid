class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :film_categories
  has_many :films, through: :film_categories
end