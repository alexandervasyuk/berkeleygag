Feature: Post management

	Show, delete

	Scenario: Deleting a post as owner
		Given I am "alexander.vasyuk@berkeley.edu"
		And I own the "Big post"
		When I delete "Big post"
		Then "Big post" is no longer in the db
		And it does not appear in the feed

	Scenario: Liking a post
		Given I am "alexander.vasyuk@berkeley.edu"
		And user with "bob@berkeley.edu" exists
		When I like "bob@berkeley.edu" post
		Then the count of "bob@berkeley.edu" post increases by 1
