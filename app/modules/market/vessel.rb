class	Market::Vessel
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title, type: String
	field :dwcc, type: Integer
	field :hold_capacity, type: Integer
	field :draft, type: Integer
	field :year_of_built, type: Integer

	validates :title, presence: true
	validates :dwcc, presence: true, numericality: { only_integer: true }
	validates :hold_capacity, presence: true
	validates :draft, presence: true
	validates :year_of_built, presence: true

	has_many :position_vessels

end
