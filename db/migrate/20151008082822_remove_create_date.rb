class RemoveCreateDate < ActiveRecord::Migration
  def change
    remove_column :customers, :create_date
  end
end
