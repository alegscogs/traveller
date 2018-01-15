require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test 'the index page displays post markers' do
    visit posts_url
    # first, assert that the map element is on the page
    assert_selector "#map"

    # test that at least one map marker was created
    assert_selector('.leaflet-marker-icon')

    # click on one of the map markers, and assert that the mini-post markup is displayed
    first('.leaflet-marker-icon').click
    assert_selector('.mini-post')
  end
end
