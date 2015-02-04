class Market::PositionVessel
	include Market::AbstractPosition

	embeds_one :vessel

	def position_type
		"position_vessel"
	end

end
