require 'rails_helper'

RSpec.feature "Users siginin" do
  before do
    @hannah = User.create(first_name: "Hannah", last_name: "Bird", email: "hannah@example.com", password: "password")
  end

  scenario "with valid credentials" do
    sign_in_user(@hannah)

    expect(page)
      .to have_content("Signed in successfully")
      .and have_content("Signed in as #{@hannah.email}")
  end

  def sign_in_user(user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end