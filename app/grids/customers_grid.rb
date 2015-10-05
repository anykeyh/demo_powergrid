model Customer do |query|
  query = query.select("cities.city").joins( :store => { :address => :city } )
end

column :first_name, fieldset: "Customer"
column :last_name, fieldset: "Customer"
column :email, fieldset: "Customer"

column :store, fieldset: "Info" do
  get do |model|
    model.store.address.city.name
  end

  sort_by do |model, direction|
    model.order("cities.city #{direction}")
  end

  filter do |model, operator, value|
    "cities.city #{operator} #{value}"
  end

  editor "Select"
  opts_for_select do |model|
    selected_id = model.store_id
    Store.with_city.order("cities.city").all.map{|s| [s.id, s.address.city.name, s.id==selected_id] }
  end
  allow_blank true
end

default_actions