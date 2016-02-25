require 'rails_helper'

RSpec.describe StoriesController, :type => :controller do
  it "returns featured stories" do
    story = Story.create(
      title: "Bootie",
      text: "I almost got into a fight with a guy who requested me to pay for his spilled drink."
    )
    get :index, format: :json
    expect(response).to be_success
  end
end
