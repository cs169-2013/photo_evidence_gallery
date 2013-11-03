Feature: Log-in
	As a Bamru Member
	So I can access other features
	I want to be able to log-in

Given the user exist:
	| profile_id	| username	| password	|
	| 1				| admin 	| password	|	

Scenario: I log-in with the right credentials
	Given I log in as "admin" and password "password"
	Then I should see "Welcome admin"

Scenario: I log-in with the wrong credentials
	Given I log in in as "admin" and password "notpassword"
	Then I should see "Invalid Credentials"
	
Scenario: I try to access features while not logged-in
	Given I log in as "admin" and password "notpassword"
	When I follow "Multiple Uploads"
	Then I should be on the PhotoApp homepage
	And I should see "Please Log-in"
	When I follow "Editing Queue"
	Then I should be on the PhotoApp homepage
	And I should see "Please Log-in"
	When I follow "Upload"
	Then I should be on the PhotoApp homepage
	And I should see "Please Log-in"

