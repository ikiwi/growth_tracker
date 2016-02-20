require 'rails_helper'

RSpec.describe StoriesController, :type => :controller do
  it "returns featured stories" do
    get :index, format: :json
    expect(response).to be_success
    #response should contain json with list of featured stories"
  end
end
