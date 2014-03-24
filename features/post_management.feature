Feature: Post management

	Show, delete

	Scenario: Deleting a post as owner
		Given I am "alexander.vasyuk@berkeley.edu"
		And I own the "Big post"
		When I delete "Big post"
		Then "Big post" is no longer in the db
		And it does not appear in the feed