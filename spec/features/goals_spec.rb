require 'rails_helper'

RSpec.feature "Goals", :type => :feature do
  scenario "#Create new goal" do
    visit "/"

    fill_in "What would you like to do", :with => "Front-end programming"
    fill_in "Why is it important to you", :with => "To make this project"
    click_button "Add Goal"

    expect(page).to have_text("saved")
  end
end