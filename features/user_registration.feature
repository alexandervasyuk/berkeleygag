Feature: User Registration

	To register a user needs to visit signup page, fill in the form with berkeley email, password, password confirmation and click sign up button.
	He will then be notified that an email was sent to his berkeley email, where he will be expected to follow a link to confirm his registration.

	Scenario: A new user fills out the form with valid data
		Given I am a guest
		When I fill out the register form with valid data
		Then I should be partially registered in the application
		And I should be logged in
		And I should receive confirmation email
		But I should not have access to posting photos

	Scenario: Partially registered user confirms his email
		Given I am partially registered user
		When I confirm my email
		Then I should have access to posting photos

	Scenario: A new user fails to register
		Given I am a guest
		When I fill out the form with invalid data
		Then I should not be registered in the application
		And I should be presented with register form again 