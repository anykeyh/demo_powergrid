class TestCistring < ActiveRecord::Migration
  def change
    enable_extension("citext")
    change_column :customers, :first_name, :citext
  end
end
