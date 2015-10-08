class Customer < ActiveRecord::Base
  belongs_to :store
  belongs_to :address

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :store, presence: true
  has_many :payments
  has_many :rentals

  def name
    [first_name, last_name].join(' ')
  end

  def set_address_field field, value
    if self.address.nil?
      self.address = Address.new
    end

    self.address.send("#{field}=", value)
  end

  def is_active?
    activebool
  end
end