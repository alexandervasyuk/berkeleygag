Feature: Create a Post

	Creating a post.

	Scenario: Create a post as logged in user
		Given I am "alexander.vasyuk@berkeley.edu"
		When I supply valid information to new post form
		Then the post should be added to the database
		And the post should have a photo
		And it should appear on the post feed
		And I as "alexander.vasyuk@berkeley.edu" should be the owner
		And it should appear on "alexander.vasyuk@berkeley.edu" wall