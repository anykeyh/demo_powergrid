class MigratePayments < ActiveRecord::Migration
  def up
    [PaymentP2007_01, PaymentP2007_02, PaymentP2007_03, PaymentP2007_04, PaymentP2007_05, PaymentP2007_06].each do |model|
      rename_column :"#{model.arel_table.name}", :payment_id, :id
      Payment.create model.all.map(&:serializable_hash)
    end
  end

  def down
    Payment.delete_all #Just because it's test data, ok?
  end
end
