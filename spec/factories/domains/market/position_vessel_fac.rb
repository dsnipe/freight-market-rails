FactoryGirl.define do

	factory :position_vessel, class: Market::PositionVessel do
		open_date { 1.days.from_now  }
		close_date { 7.days.from_now }
		after(:create) { |vp| FactoryGirl.create(:vessel, position_vessel: vp) }
	end

end
