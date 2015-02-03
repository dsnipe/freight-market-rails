class Market::PositionVessel
	include Market::AbstractPosition

	embeds_one :vessel
end
