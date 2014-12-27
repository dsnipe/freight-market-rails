FactoryGirl.define do 

	factory :vessel_position do
		open_date { 1.days.from_now  }
		close_date { 7.days.from_now }
		after(:create) { |vp| FactoryGirl.create(:vessel, vessel_position: vp) }
	end

end