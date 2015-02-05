class Market::PositionCargoFactory
  include Wisper::Publisher

  attr_accessor :position_cargo, :cargo, :result
  attr_accessor :dwcc, :open_date, :close_date, :state

  def initialize(args={})
    raise ArgumentError.new('There is should be arguments') if args.size == 0
    args.each do |p, val|
      send("#{p}=", val)
    end
    @state = :active # default state for new position
  end

  def save
    create_template
    finilize_save
    broadcast
  end

  private

    def create_template
      # Create template here, don't want
    end

    def finilize_save
      data = {
        open_date: @open_date,
        close_date: @close_date,
        dwcc: @dwcc,
        state: @state
      }
      @result = Market::PositionCargo.create(data)
    end

    def broadcast
      if @result.valid?
        publish :succesful, @result
      else
        publish :error, @result.errors
      end
      @result
    end
end
