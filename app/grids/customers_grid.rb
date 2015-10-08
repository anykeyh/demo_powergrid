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

#t.string   "address",     limit: 50,                                 null: false
#t.string   "address2",    limit: 50
#t.string   "district",    limit: 20,                                 null: false
#t.integer  "city_id",     limit: 2,                                  null: false
#t.string   "postal_code", limit: 10
#t.string   "phone",       limit: 20,                                 null: false

[:address, :address2, :district, :postal_code, :phone].each do |address_field|
  column address_field, visible: false, fieldset: "Address" do
    editor "Text"
    get{ |model| model.address.try(address_field) }
    set{ |model, value| model.set_address_field(address_field, value) }
  end
end

column :city, visible: false, fieldset: "Address" do
  get{ |model| model.address.try(:city_id) }
  set{ |model, value| model.set_address_field(:city_id, value) }

  editor "Select"
  opts_for_select do |model|
    selected_id = model.address.try(:city_id)
    City.order("cities.city").all.map{|s| [s.id, s.name, s.id==selected_id] }
  end
  allow_blank true
end



default_actions