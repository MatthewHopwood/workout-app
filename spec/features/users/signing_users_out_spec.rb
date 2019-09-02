require 'rails_helper'

RSpec.feature "Users signout" do
  before do
    @hannah = User.create!(email: "hannah@example.com", password: "password")
    sign_in_user(@hannah)

  end

  scenario do
    visit "/"
    click_link "Sign out"

    expect(page)
      .to have_content("Signed out successfully.")
  end

  def sign_in_user(user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

end