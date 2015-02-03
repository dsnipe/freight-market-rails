class Market::PositionVessel
	include Market::AbstractPosition

	has_one :vessel

	def position_type
		"position_vessel"
	end
	
end
