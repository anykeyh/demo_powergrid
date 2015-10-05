model Rental do |query|
  #query = query.joins(:customer, {:inventory => :film}, :staff => { :store => { :address => :city } } )
  query.joins(:customer, {:inventory => :film}, :staff => { :store => { :address => :city } })
end

column :rental_date
column :return_date

column :customer, editable: false do
  get{ |model| model.customer.name }

  sort_by do |model, direction|
    model.order("customers.last_name #{direction}")
  end

  filter do |field, operator, value|
    "customers.last_name #{operator} #{value} OR customers.first_name #{operator} #{value}"
  end

end

column :staff, editable: false do
  get do |resource|
    resource.staff.username
  end

  sort_by do |model, direction|
    model.order("staffs.username #{direction}")
  end

  filter do |model, operator, value|
    "staffs.username #{operator} #{value}"
  end
end

column :store, editable: false do
  get do |model|
    model.staff.store.address.city.name
  end

  sort_by do |model, direction|
    model.order("cities.city #{direction}")
  end

  filter do |model, operator, value|
    "cities.city #{operator} #{value}"
  end
end

column :film, editable: false do
  get{|model| model.inventory.film.title }

  sort_by do |model, direction|
    model.order("films.title #{direction}")
  end

  filter do |model, operator, value|
    "films.title #{operator} #{value}"
  end

end

default_actions