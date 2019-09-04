require 'rails_helper'

RSpec.feature "Sending a message" do
  before do
    @hannah = User.create!(first_name: "Hannah", last_name: "Bird", email: "hannah@example.com", password: "password")
    @matthew = User.create!(first_name: "Matthew", last_name: "Hopwood", email: "matthew@example.com", password: "password")
    @lewis = User.create!(first_name: "Lewis", last_name: "Hudson", email: "lewis@example.com", password: "password")

    @room_name = @hannah.first_name + '-' + @hannah.last_name
    @room = Room.create!(name: @room_name, user_id: @hannah.id)

    login_as(@hannah)

    Friendship.create(user: @matthew, friend: @hannah)
    Friendship.create(user: @lewis, friend: @hannah)
  end

  scenario "to followers, shows in chatroom window" do
    visit '/'

    click_link "My Lounge"
    expect(page).to have_content(@room_name)

    fill_in "message-field", with: "Hello"
    click_button "Post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page)
        .to have_link(@matthew.full_name)
        .and have_link(@lewis.full_name)
    end
  end
end