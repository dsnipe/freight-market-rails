class Market::PositionCargoTemplate
	include Mongoid::Document
	include Mongoid::Timestamps

	field :quantity, type: Integer
	field :dwcc, type: Integer
	field :sf, type: Integer
	field :cargo_description, type: String
	field :loading_discharging_rate, type: String
	field :freight_idea, type: Integer
	field :commission, type: Float
	field :extra_conditions, type: String

	validates :dwcc, presence: true

end
