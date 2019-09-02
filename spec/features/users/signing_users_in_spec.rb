require 'rails_helper'

RSpec.feature "Users siginin" do
  before do
    @hannah = User.create(email: "hannah@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"

    click_link "Sign in"

    fill_in "Email", with: @hannah.email

    fill_in "Password", with: @hannah.password

    click_button "Log in"

    expect(page)
      .to have_content("Signed in successfully")
      .and have_content("Signed in as #{@hannah.email}")
  end
end