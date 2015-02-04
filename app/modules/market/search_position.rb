module Market::SearchPosition

  def self.find_matches_for(position)
    ByMatches.new(position).result
  end
  def self.by_params_for_cargo_positions(params={})
    search = ByParams.new(params)
    search.for_cargo()
  end

  def self.by_params_for_vessel_positions(params={})
    search = ByParams.new(params)
    search.for_vessel()
  end

end
