FactoryGirl.define do

	factory :position_cargo, class: Market::PositionCargo do
		# association :user, factory: :user_broker
		open_date { 1.days.from_now  }
		close_date { 7.days.from_now }
		sf '50'
		quantity '15'
		dwcc '3000'
		cargo_description 'Some description'
		loading_discharging_rate '2000 ssinc/3000 sshex'
		freight_idea '15'
		commission '6'
		extra_conditions 'Bla bla bla'

		# before(:create) do |rec|
		#   rec.from_ports = [create(:port,  title: 'from port')]
		#   rec.to_ports = [create(:port,  title: 'to port')]
		# end
	end

end
