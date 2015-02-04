class Market::PositionVessel
	include Market::AbstractPosition

	belongs_to :vessel

	def position_type
		"position_vessel"
	end

end
