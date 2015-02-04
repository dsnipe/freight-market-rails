FactoryGirl.define do

	factory :vessel, class: Market::Vessel do
		title 'Test Vessel'
		dwcc '3000'
		hold_capacity '2600'
		draft '10'
		year_of_built '1970'
		# association :position_vessel, factory: :position_vessel
		# association :user, factory: :user_broker
		# association :specialization, factory: :vessel_specialization
		# association :ship_type, factory: :ship_type
		# association :country
	end

end
