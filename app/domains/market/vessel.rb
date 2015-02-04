class	Market::Vessel
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title, type: String
	field :dwcc, type: Integer
	field :hold_capacity, type: Integer
	field :draft, type: Integer
	field :year_of_built, type: Integer

	embedded_in :position_vessel
end
