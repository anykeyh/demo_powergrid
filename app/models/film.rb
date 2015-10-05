class Film < ActiveRecord::Base
  has_many :film_actors
  has_many :actors, :through => :film_actors
  has_many :categories, :through => :film_category

  has_many :inventories
  has_many :stores, :through => :inventories
end