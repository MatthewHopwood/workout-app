require 'rails_helper'

RSpec.feature "Following Friends" do
  before do
    @hannah = User.create!(first_name: "Hannah",
                            last_name: "Hopwood",
                            email: "hannah@example.com",
                            password: "password")

    @matthew = User.create!(first_name: "Matthew",
                            last_name: "Hopwood",
                            email: "matthew@example.com",
                            password: "password")
    login_as(@hannah)
  end

  scenario "if signed in" do
    visit '/'

    expect(page)
      .to have_content(@hannah.full_name)
      .and have_content(@matthew.full_name)

      href = "friendships?friend_id=#{@hannah.id}"
      expect(page).to have_no_link("Follow", :href => href)

      link = "a[href='/friendships?friend_id=#{@matthew.id}']"
      find(link).click

      href = "/friendshipsfriend_id=#{@matthew.id}"
      expect(page).to have_no_link("Follow", :href => href)
  end
end