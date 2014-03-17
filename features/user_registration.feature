Feature: User Registration

	To register a user needs to visit signup page, fill in the form with berkeley email, password, password confirmation and click sign up button.
	He will then be notified that an email was sent to his berkeley email, where he will be expected to follow a link to confirm his registration.

	Scenario: A new user fills out the form with valid data
		Given I am a guest
		When I fill out the register form with "alexander.vasyuk@berkeley.edu" valid data
		Then I should be partially registered in the application with "alexander.vasyuk@berkeley.edu"
		And I should be logged in as "alexander.vasyuk@berkeley.edu"
		And I should receive confirmation email to "alexander.vasyuk@berkeley.edu"
		But I as user "alexander.vasyuk@berkeley.edu" should not have full priviliges

	Scenario: Partially registered user confirms his email
		Given I am partially registered user "alexander.vasyuk@berkeley.edu"
		And I received an email at "alexander.vasyuk@berkeley.edu"
		When I open the email
		Then I should see "Confirm your registration" in the email body
		When I follow "Confirm your registration" link in the email body
		Then I should have full priviliges as "alexander.vasyuk@berkeley.edu" user

	Scenario: A new user fails to register
		Given I am a guest
		When I fill out the form with invalid data
		Then I should not be registered in the application
		And I should know what went wrong
		And I should be presented with register form again