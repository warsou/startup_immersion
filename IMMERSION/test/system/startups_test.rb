require "application_system_test_case"

class StartupsTest < ApplicationSystemTestCase
  setup do
    @startup = startups(:one)
  end

  test "visiting the index" do
    visit startups_url
    assert_selector "h1", text: "Startups"
  end

  test "creating a Startup" do
    visit startups_url
    click_on "New Startup"

    fill_in "Catch phrase", with: @startup.catch_phrase
    fill_in "Description", with: @startup.description
    fill_in "Name", with: @startup.name
    fill_in "Website url", with: @startup.website_url
    click_on "Create Startup"

    assert_text "Startup was successfully created"
    click_on "Back"
  end

  test "updating a Startup" do
    visit startups_url
    click_on "Edit", match: :first

    fill_in "Catch phrase", with: @startup.catch_phrase
    fill_in "Description", with: @startup.description
    fill_in "Name", with: @startup.name
    fill_in "Website url", with: @startup.website_url
    click_on "Update Startup"

    assert_text "Startup was successfully updated"
    click_on "Back"
  end

  test "destroying a Startup" do
    visit startups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Startup was successfully destroyed"
  end
end
