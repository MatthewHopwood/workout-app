require 'rails_helper'

RSpec.feature "Hiding signin link" do

  before do
    @hannah = User.create!(email: "hannah@example.com", password: "password")
  end

  scenario "upon successful signin" do

    visit "/"

    click_link "Sign in"

    fill_in "Email", with: @hannah.email

    fill_in "Password", with: @hannah.password

    click_button "Log in"

    expect(page)
      .to have_link("Sign out")
      .and have_no_link("Sign in")
      .and have_no_link("Sign up")
  end
end