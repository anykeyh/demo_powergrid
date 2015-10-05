class Store < ActiveRecord::Base
  belongs_to :manager, :foreign_key => "manager_staff_id", :class_name => "Staff"
  belongs_to :address

  has_many :staffs

  has_many :customers

  has_many :inventories
  has_many :films, :through => :inventories
  has_many :payments

  scope :with_city, -> { joins(:address => :city) }
end