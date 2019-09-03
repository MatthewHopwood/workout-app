require 'rails_helper'

RSpec.feature "Searching for User" do
  before do
    @hannah = User.create!(first_name: "Hannah",
                            last_name: "Hopwood",
                            email: "hannah@example.com",
                            password: "password")

    @matthew = User.create!(first_name: "Matthew",
                            last_name: "Hopwood",
                            email: "matthew@example.com",
                            password: "password")
  end

  scenario "with existing name returns all those users" do
    visit '/'

    fill_in "search_name", with: "Hopwood"
    click_button "Search"

    expect(page)
      .to have_content(@matthew.full_name)
      .and have_content(@hannah.full_name)

    expect(current_path).to eq("/dashboards/search")
  end
end