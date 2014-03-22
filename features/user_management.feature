Feature: User managment

	Show, edit, update, destroy

	Scenario: Visiting edit page
		Given I am "alexander.vasyuk@berkeley.edu"
		When I visit "alexander.vasyuk@berkeley.edu" profile page
		And I click "edit" link
		Then I see the edit form for "alexander.vasyuk@berkeley.edu"

	Scenario: Changing password
		Given I am "alexander.vasyuk@berkeley.edu"
		When I fill in edit form with valid data for "alexander.vasyuk@berkeley.edu"
		Then I am redirected to profile page of "alexander.vasyuk@berkeley.edu"
		And I have a success notice
		And "alexander.vasyuk@berkeley.edu" password is changed