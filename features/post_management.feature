Feature: Post management

	Show, delete

	Scenario: Deleting a post as owner
		Given I am "alexander.vasyuk@berkeley.edu"
		And I own the "Big post"
		When I delete "Big post"
		Then "Big post" is no longer in the db
		And it does not appear in the feed

	Scenario: Trying to delete a post I don't own
		Given I am "badboy@berkeley.edu"
		When I try to delete "Big post" owned by "alexander.vasyuk@berkeley.edu"
		Then I get access denied