Feature: User managment

	Show, edit, update, destroy as authorized and not authorizes user

	Scenario: Showing current user's profile page
		Given I am "alexander.vasyuk@berkeley.edu"
		And I have 3 posts
		When I visit "alexander.vasyuk@berkeley.edu" profile
		Then I should see 3 "alexander.vasyuk@berkeley.edu" posts

	Scenario: Showing other user's profile page 
		Given I am "badboy@berkeley.edu"
		And user with "alexander.vasyuk@berkeley.edu" exists
		When I try to access "alexander.vasyuk@berkeley.edu"
		Then I should be redirected to access_denied_path

	Scenario: Trying to access non-existent user's page
		Given I am "alexander.vasyuk@berkeley.edu"
		When I try to access profile of user with id 0
		Then I should be redirected to access_denied_path

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