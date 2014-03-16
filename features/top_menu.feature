Feature: Top menu
	
	There are three types of top menus:
	1. Guest: Sign up, Sign in links
	2. Logged in user
	3. Admin

	Scenario: Guest
		Given I am a guest
		When I go to home page
		Then I should see guest menu

	Scenario: User
		Given I am "alex@berkeley.edu"
		When I go to home page
		Then I should see "alex@berkeley.edu" menu