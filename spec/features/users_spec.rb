require 'rails_helper'

RSpec.feature "Users", :type => :feature do
  scenario "#Create new user" do
    visit "/users/new"

    fill_in "Username", :with => "k"
    fill_in "Email", :with => "kalai.wei@gmail.com"
    fill_in "Password", :with => "k"
    click_button "Sign Up"

    expect(page).to have_text("Welcome k")
  end

  scenario "#Login#error" do
    visit "/"

    fill_in "Email", :with => "kalai.wei@gmail.com"
    fill_in "Password", :with => "k"
    click_button "Login"

    expect(page).to have_text("Cannot login")
  end

  scenario "#Login#success" do

    visit "/users/new"

    fill_in "Username", :with => "k"
    fill_in "Email", :with => "kalai.wei@gmail.com"
    fill_in "Password", :with => "k"
    click_button "Sign Up"

    click_button "Logout"

    visit "/"

    fill_in "Email", :with => "kalai.wei@gmail.com"
    fill_in "Password", :with => "k"
    click_button "Login"

    expect(page).to have_text("Hello k")
  end
end