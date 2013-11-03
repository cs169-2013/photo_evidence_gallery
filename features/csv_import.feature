Feature: CSV_Import
	As a Bamru Member
	So I can add other users
	I want to be able to import user data via a csv file

Given the user exist:
	| profile_id	| username	| password	|
	| 1				| admin 	| password	|	
	
Scenario: I upload a correctly formatted csv file
	Given I log in as "admin" and password "notpassword"
	Then I should be on the PhotoApp homepage
	When I follow "Upload Users"
	Then I should be on the CSV page
	When I upload the file "user.txt"
	Then I should see "new_user1 Created!"
	Then I should see "new_user2 Created!" 
	When I log-out
	And I log in as "new_user1" and password "password"
	Then I should see "Welcome new_user"  
