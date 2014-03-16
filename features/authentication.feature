Feature: Authentication

	Scenario: Successful login
		Given I am a guest
		And reader with "alex@berkeley.edu" exists
		When I fill out the login form for "alex@berkeley.edu"
		Then I am logged in as "alex@berkeley.edu"

	Scenario: Succesful logout
		Given I am "alex@berkeley.edu"
		When I click on signout
		Then I am logged out

	Scenario: Unsuccessful login
		Given I am a guest
		And reader with "alexa@berkeley.edu" does not exist
		When I fill out the login form for "alexa@berkeley.edu"
		Then I should not be logged in
		And I should be prompted with signin form again
		And I should see my errors