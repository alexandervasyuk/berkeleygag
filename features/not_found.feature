Feature: A page was not found

	Scenario: Trying to access a page that does not exist
		Given I am anyone
		When I try to access a page that does not exist
		Then I am redirected to a not_found_path