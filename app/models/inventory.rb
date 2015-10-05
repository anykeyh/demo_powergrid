class Inventory < ActiveRecord::Base
  belongs_to :film
  belongs_to :store
end