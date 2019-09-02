require 'rails_helper'

RSpec.feature "Creating Exercise" do
  before do
    @hannah = User.create!(email: "hannah@example.com", password: "password")
    login_as(@hannah)
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"
  end

  scenario "with valid inputs" do

    expect(page).to have_link("Back")

    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight lifting"
    fill_in "Activity Date", with: "2019-09-02"
    click_button "Create Workout"

    expect(page).to have_content("Exercise has been created")

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@hannah, exercise))

    expect(exercise.user_id).to eq(@hannah.id)

  end

  scenario "with invalid inputs" do

    fill_in "Duration", with: ""
    fill_in "Workout Details", with: ""
    fill_in "Activity Date", with: ""
    click_button "Create Workout"

    expect(page)
      .to have_content("Exercise has not been created")
      .and have_content("Duration in min is not a number")
      .and have_content("Workout details can't be blank")
      .and have_content("Activity date can't be blank")

  end


end