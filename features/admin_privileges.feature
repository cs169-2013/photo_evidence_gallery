Feature: Admin privileges

	As a Bamru Administrator, So I can monitor other accounts, I want to be able to have more control over the site than other users
	As a Bamru Admin, So I can remove unauthorized users, I want to be able to selectively remove user accounts.
	As a Bamru member, So unauthorized people can't register accounts, I want the site to be secure and private against outsiders

Background: I am on the homepage
	
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage

Scenario: Delete another user
	Given another valid admin exists
	When I follow "All Users"
	And I follow "delete"
	Then I should see "User destroyed."

Scenario: Attempt to sign up
	When I follow "Logout"
	Then I should not see "Sign Up"

Scenario: As a viewer
	When I follow "Logout"
	When I am logged in as a valid viewer
	When I follow "All Users"
	Then I should not see "delete"