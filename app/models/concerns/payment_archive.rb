module PaymentArchive
  extend ActiveSupport::Concern

  included do
    belongs_to :payment
    belongs_to :customer
    belongs_to :staff
    belongs_to :rental

    validates :amount, presence: true
    validates :payment_date, presence: true
  end

end