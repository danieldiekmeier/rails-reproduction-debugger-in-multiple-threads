require "application_system_test_case"

class ThreadingsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit threadings_url
  #
  #   assert_selector "h1", text: "Threading"
  # end

  test "threading" do
      visit root_path
      assert_text "Finished"
  end
end
