class Market::SearchPosition::ByMatches
  attr_accessor :position, :result

  def initialize(position)
    @position = position

    case position.position_type
    when 'position_cargo'
      for_position_cargo
    when 'position_vessel'
      for_position_vessel
    end
  end

  # There is should be different algorithms for positions
  def for_position_cargo
    @result = ::Market::Vessel.gte(dwcc: @position.dwcc)
                              .map(&:position_vessels)
                              .flatten
  end

  def for_position_vessel
    @result = ::Market::PositionCargo.gte(dwcc: @position.vessel.dwcc)
  end
end
