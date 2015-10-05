model Store do |query|
  query.select(
    "COUNT(DISTINCT staffs.id) as staff_count, SUM(payments.amount) as total_paid"
  ).joins(
    "INNER JOIN addresses ON (addresses .id = stores.address_id)"
  ).joins(
    "INNER JOIN cities ON (addresses.city_id = cities.id)"
  ).joins(
    "LEFT JOIN staffs ON (staffs.store_id = stores.id)"
  ).joins(
    "LEFT JOIN staffs man_staff ON (stores.manager_staff_id = man_staff.id)"
  ).joins(
    "LEFT JOIN payments ON (payments.staff_id = staffs.id)"
  ).includes(
    :manager, { :address => :city }
  ).group("stores.id, man_staff.username, cities.city, staffs.id")
end

column :address, label: "Shop name" do
  get { |model|
    model.address.city.city
  }

  sort_by do |query, direction|
    query.order("cities.city #{direction}")
  end

  editable false
end

column :staff_count do
  get { |model|
    model.staff_count
  }

  aggregate true

  sort_by do |query, direction|
    query.order("staff_count #{direction}")
  end

  filter do |query, operator, value|
    "COUNT(DISTINCT staffs.id) #{operator} #{value}"
  end
end

column :manager, label: "Manager" do
  get { |model|
    model.manager.username
  }
  sort_by do |query, direction|
    query.order("man_staff.username #{direction}")
  end
end

column :total_paid, label: "Turnover" do
  aggregate true

  renderer :money

  get do |model|
    model.total_paid
  end

  sort_by do |query, direction|
    query.order("total_paid #{direction}")
  end

  filter do |query, operator, value|
    "SUM(payments.amount) #{operator} #{value}"
  end

end

default_actions
