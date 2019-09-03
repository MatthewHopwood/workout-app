require 'rails_helper'

RSpec.feature "Listing Exercises" do
  before do
    @hannah = User.create!(first_name: "Hannah", last_name: "Bird", email: "hannah@example.com", password: "password")
    @matthew = User.create!(first_name: "Matthew", last_name: "Hopwood", email: "matthew@example.com", password: "password")
    login_as(@hannah)

    @e1 = @hannah.exercises.create(duration_in_min: 20,
                                    workout: "My body building activity",
                                    workout_date: Date.today)

    @e2 = @hannah.exercises.create(duration_in_min: 55,
                                    workout: "Weight lifting",
                                    workout_date: 2.days.ago)

    @following = Friendship.create(user: @hannah, friend: @matthew)
    # @e3 = @hannah.exercises.create(duration_in_min: 35,
    #                                   workout: "On treadmill",
    #                                   workout_date: 8.days.ago)
  end

  scenario "shows user's workout for last 7 days" do
    visit '/'

    click_link "My Lounge"

    expect(page)
      .to have_content(@e1.duration_in_min)
      .and have_content(@e1.workout)
      .and have_content(@e1.workout_date)
      .and have_content(@e2.duration_in_min)
      .and have_content(@e2.workout)
      .and have_content(@e2.workout_date)
      # .and have_no_content(@e3.duration_in_min)
      # .and have_no_content(@e3.workout)
      # .and have_no_content(@e3.workout_date)

  end

  scenario "shows no exercises if non created" do
    @hannah.exercises.delete_all

    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content("No Workouts Yet")

  end

  scenario "shows a list of user's frinds" do
    visit '/'

    click_link "My Lounge"
    expect(page)
      .to have_content("My Friends")
      .and have_link(@matthew.full_name)
      .and have_link("Unfollow")

  end
end