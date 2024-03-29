Feature: Authentication

	Scenario: Successful login
		Given I am a guest
		And user with "alex@berkeley.edu" exists
		When I fill out the login form for "alex@berkeley.edu"
		Then I am logged in as "alex@berkeley.edu"

	Scenario: Succesful logout
		Given I am "alex@berkeley.edu"
		When I click on signout
		Then I am logged out

	Scenario: Unsuccessful login
		Given I am a guest
		And user with "alexa@berkeley.edu" does not exist
		When I fill out the login form for "alexa@berkeley.edu"
		Then I should not be logged in
		And I should be prompted with signin form again
		And I should see my errors

	Scenario: Access a page that requires login
		Given I am a guest
		When I access a page that requires login
		Then I should be redirected to sign in page