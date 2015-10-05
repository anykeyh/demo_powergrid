class FilmActor < ActiveRecord::Base
  belongs_to :actor
  belongs_to :film
end