class Market::PositionVesselFactory
  include Wisper::Publisher

  attr_accessor :position_vessel, :vessel, :result
  attr_accessor :dwcc, :title, :hold_capacity, :draft, :year_of_built,
                :open_date, :close_date, :state

  def initialize(args={})
    raise ArgumentError.new('There is should be arguments') if args.size == 0
    args.each do |p, val|
      send("#{p}=", val)
    end
    @state = :active # default state for new position
  end

  def save
    save_vessel
    finilize_save
    broadcast
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
        @result = Market::PositionVessel.create(data)
      else
        @result = @vessel
      end
    end

    def broadcast
      if @result.valid?
        publish :succesful, @result
      else
        publish :error, @result.errors
      end
      @result # happy tests. Return object, if direct invocation
    end

end
