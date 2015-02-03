class Market::PositionCargo < Market::PositionCargoTemplate
	include Market::AbstractPosition

	def position_type
		"position_cargo"
	end

end
