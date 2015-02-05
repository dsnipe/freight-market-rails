require "rails_helper"

describe "Authentification" do

  it "should return unauth status" do
    get '/api/positions'
    expect_status('401')
  end

  it "should return 200" do
    get '/api/positions', nil, { 'X-AUTH-TOKEN' => 'superpupertoken' }
    expect_status('200')
  end
end
