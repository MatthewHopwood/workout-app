require 'rails_helper'

RSpec.feature "Showing Friend Workout" do
  before do
    @hannah = User.create!(first_name: "Hannah", last_name: "Bird", email: "hannah@example.com", password: "password")
    @matthew = User.create!(first_name: "Matthew", last_name: "Hopwood", email: "matthew@example.com", password: "password")

    @e1 = @hannah.exercises.create(duration_in_min: 74, workout: "My body building activity", workout_date: Date.today)
    @e2 = @matthew.exercises.create(duration_in_min: 55, workout: "Weight lifting", workout_date: Date.today)

    login_as(@hannah)

    @following = Friendship.create(user: @hannah, friend: @matthew)
  end

  scenario "shows friend's workout for last 7 days" do
    visit "/"

    click_link "My Lounge"
    click_link @matthew.full_name

    expect(page)
      .to have_content(@matthew.full_name + "'s Exercises")
      .and have_content(@e2.workout)
      .and have_css("div#chart")
  end
end