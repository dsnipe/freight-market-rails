shared_context "API Helpers" do

  before(:each) do
    # Auth stubbing
    Grape::Endpoint.before_each do |endpoint|
      allow(endpoint).to receive(:authenticated).and_return(true)
    end
  end

  after do
    Grape::Endpoint.before_each nil
  end

  def prepare_record(record)
    JSON.parse(record.to_json, symbolize_names: true)
  end

end
