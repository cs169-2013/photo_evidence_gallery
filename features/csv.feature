
Feature: CSV_Import
	As a Bamru Member
	So I can add other users
	I want to be able to import and export user data via a csv file

Background: I am on the homepage
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage

@wip
Scenario: I download a correctly formatted csv file
	When I follow "CSV"
	Then I should be on the CSV page
	When I follow "Export User Data"
	Then I should get download with the filename "users.csv"
	
Scenario: I upload a correctly formatted csv file
	When I follow "CSV"
	Then I should be on the CSV page
	When I upload the file "user_add_test.csv"
	And I press "Import"
	Then I should see "Successfully created chiller@berkeley.edu. The password is admin169"
	When I follow "Logout"
	And I log in as "chiller@berkeley.edu" and password "admin169"
	Then I should see "Signed in successfully."  
