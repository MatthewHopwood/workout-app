require 'rails_helper'

RSpec.feature "Unfollowing Friend" do
  before do
    @hannah = User.create!(first_name: "Hannah", last_name: "Bird", email: "hannah@example.com", password: "password")
    @matthew = User.create!(first_name: "Matthew", last_name: "Hopwood", email: "matthew@example.com", password: "password")

    login_as(@hannah)

    @following = Friendship.create(user: @hannah, friend: @matthew)
  end

  scenario do
    visit '/'

    click_link "My Lounge"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@matthew.full_name + " unfollowed")
  end
end