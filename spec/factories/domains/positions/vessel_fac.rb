FactoryGirl.define do 

	factory :vessel do
		title 'Test Vessel'
		dwcc '3000'
		hold_capacity '2600'
		draft '10'
		year_of_built '1970'
		vessel_position
		# association :user, factory: :user_broker
		# association :specialization, factory: :vessel_specialization
		# association :ship_type, factory: :ship_type
		# association :country
	end

end