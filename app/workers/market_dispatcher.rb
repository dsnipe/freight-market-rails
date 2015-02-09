class MarketDispatcher
  include Sneakers::Worker
  from_queue 'cargo-vessel.market'

  def work(raw_data)
    logger.info "[X] We got a data: #{raw_data}"
    data = JSON.parse(raw_data, symbolize_names: true)

    service = ::Market::PositionCargoFactory.new(data)

    service.on :succesful do |result|
      ack!
      logger.info "Position created #{result}"
    end

    service.on :error do |errors|
      logger.error "We got a errors #{errors}"
    end

    service.save
  end

end
