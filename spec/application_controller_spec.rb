require_relative "spec_helper"

def app
  ApplicationController
end

describe ApplicationController do
  it "responds with a welcome message" do
    get '/'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Lift Tracker")
  end

  it 'has a link to the signup page' do
    get '/signup'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("<form action='/signup'>")
  end

end
