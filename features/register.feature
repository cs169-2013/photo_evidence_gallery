Feature: Register
	As a Bamru Member
	So I can have an account
	I want to be able to register
Background: Given
 the user exist:
	| profile_id	| username	| password	|
	| 1				| admin 	| password	|	

Scenario: I register an existing account
	Given I register as "admin" and password "password"
	Then I should see "admin aleady exists"

Scenario: I register a new account
	Given I register as "new_user" and password "password"
	Then I should be on the PhotoApp homepage
	And I should see "new_user Created!"
	When I follow "Logout"
	Then I should be on the PhotoApp homepage
	And I should see "Register"
	And I should see "Log-in"
	Given I log in as "admin" and password "notpassword"
	Then I should see "Welcome admin"
