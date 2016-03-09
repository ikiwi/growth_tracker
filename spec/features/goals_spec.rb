require 'rails_helper'

RSpec.feature "Goals", type: :feature, js: true do
  scenario "#Create new goal" do

    visit "/users/new"

    fill_in "Username", with: "k"
    fill_in "Email", with: "kalai.wei@gmail.com"
    fill_in "Password", with: "k"
    click_button "Sign Up"

    fill_in "What would you like to do", :with => "Front-end programming"
    fill_in "Why is it important to you", :with => "To make this project"
    click_button "Add Goal"

    expect(page).to have_text("Front-end programming")
  end
end
