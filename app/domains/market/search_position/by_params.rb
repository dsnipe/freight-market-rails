class Market::SearchPosition::ByParams
  attr_accessor :params

  def initialize(params={})
    raise ArgumentError.new('Params should by not empty') if params.size == 0
    @params = params
  end

  def for_cargo
    @result = ::Market::PositionCargo.where(dwcc: @params[:dwcc])
  end

  def for_vessel
    @result = ::Market::PositionVessel.where('vessel.dwcc' => @params[:dwcc])
  end
end
