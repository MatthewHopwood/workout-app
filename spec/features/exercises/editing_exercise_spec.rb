require 'rails_helper'

RSpec.feature "Editing Exercise" do
  before do
    @owner = User.create!(first_name: "Owner", last_name: "Owned", email: "owner@example.com", password: "password")

    @owner_exercise = @owner.exercises.create!(duration_in_min: 48,
                                                workout: "My body building activity",
                                                workout_date: Date.today)
    login_as(@owner)
  end

  scenario "with valid data succeeds" do
    visit '/'

    click_link "My Lounge"

    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click

    fill_in "Duration", with: 45
    click_button "Update Workout"

    expect(page)
      .to have_content("Exercise has been updated")
      .and have_content(45)
      .and have_no_content(48)

  end
end