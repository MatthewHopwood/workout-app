require 'rails_helper'

RSpec.feature "Listing Members" do
  before do
    @hannah = User.create!(first_name: "Hannah",
                           last_name: "Bird",
                           email: "hannah@example.com",
                           password: "password")
    @matthew = User.create!(first_name: "Matthew",
                            last_name: "Hopwood",
                            email: "matthew@example.com",
                            password: "password")
  end

  scenario "shows a list of registered users" do
    visit '/'

    expect(page)
      .to have_content("List of Members")
      .and have_content(@hannah.full_name)
      .and have_content(@matthew.full_name)
  end
end