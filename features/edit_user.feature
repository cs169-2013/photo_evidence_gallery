Feature: Editing myself

	As a Bamru member, so I can protect my account from attackers I want to be able to change my email and password

Background: I am on the homepage
	
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage

Scenario: Successfully edit my email and password
	When I follow "Edit profile"
	And I fill in "Email" with "xXDragonSlayerXx@hotmail.com"
	And I fill in "Password" with "Dragonmaster"
	And I fill in "Password confirmation" with "Dragonmaster"
	And I fill in "Current password" with "12345678"
	And I press "Update"
	Then I should be on the login page
	And I log in as "xXDragonSlayerXx@hotmail.com" and password "Dragonmaster"
	Then I should see "Signed in successfully."

Scenario: Fail to edit my profile
	When I follow "Edit profile"
	And I fill in "Email" with "xXDragonSlayerXx@hotmail.com"
	And I fill in "Current password" with "hacker4lyfe"
	And I press "Update"
	Then I should see "Current password incorrect."
	And I fill in "Email" with "xXDragonSlayerXx@hotmail.com"
	And I fill in "Password" with "Dragonmaster"
	And I fill in "Password confirmation" with "clearlyatypo"
	And I fill in "Current password" with "12345678"
	And I press "Update"
	Then I should see "Passwords do not match."
	And I fill in "Email" with "clearly not an email"
	And I fill in "Current password" with "12345678"
	And I press "Update"
	Then I should see "Couldn't update user"

Scenario: Successfully delete myself
	When I follow "Edit profile"
	And I press "Cancel my account"
	Then I should be on the login page
	And I log in as "minikermit@hotmail.com" and password "12345678"
	Then I should be on the login page
