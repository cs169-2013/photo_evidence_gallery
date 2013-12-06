Feature: CSV_Import
	As a Bamru Member
	So I can add other users
	I want to be able to import and export user data via a csv file

Background: I am on the homepage
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage

Scenario: I download a correctly formatted csv file
	When I follow "CSV"
	When I follow "Excel"
	Then I should get a download with the filetype "application/xls"
	
Scenario: I upload a correctly formatted csv file
	When I follow "CSV"
	Then I should be on the CSV page
	When I upload the file "user_add_test.csv"
	And I press "Import"
	Then I should see "Successfully created chiller@berkeley.edu as a member. The password is bamru12345"
	When I follow "Logout"
	And I log in as "chiller@berkeley.edu" and password "bamru12345"
	Then I should see "Signed in successfully."  

Scenario: I upload an incorrectly formatted csv file
	When I follow "CSV"
	Then I should be on the CSV page
	When I upload the file "user_add_bad_test.csv"
	And I press "Import"
	Then I should see "Failed to create a row, did not have email and role"
	Then I should see "Failed to create thisisnotanemailaddress, did not have a valid email"
	When I upload the file "user_invalid_test.csv"
	Then I should see "Failed to create andyl@berkeley.edu {:email=>["has already been taken"]}"
