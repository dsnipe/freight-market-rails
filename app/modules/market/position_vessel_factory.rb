class Market::PositionVesselFactory
  attr_accessor :position_vessel, :vessel
  attr_accessor :dwcc, :title, :hold_capacity, :draft, :year_of_built,
                :open_date, :close_date, :state

  def initialize(args={})
    raise ArgumentError.new('There is should be arguments') if args.size == 0
    args.each do |p, val|
      send("#{p}=", val)
    end
  end

  def save
    save_vessel
    finilize_save
  end

  private

    def save_vessel
      data = {
        title: @title,
        dwcc: @dwcc,
        hold_capacity: @hold_capacity,
        draft: @draft,
        year_of_built: @year_of_built
      }
      @vessel = Market::Vessel.create(data)
    end

    def finilize_save
      if @vessel.valid?
        data = {
          open_date: @open_date,
          close_date: @close_date,
          state: @state,
          vessel: @vessel
        }
        @position_vessel = Market::PositionVessel.create(data)
      else
        @vessel
      end
    end

end
