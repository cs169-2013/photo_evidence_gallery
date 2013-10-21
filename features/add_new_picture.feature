Feature: Upload a single image to the app

	As a photographer
	So I can add relevant photos to the database
	I want to have the database updated
	
Background: I am on the homepage

	Given I am on the Photo/Evidence Gallery homepage
	
Scenario: uploading a single photo
	When I follow "New Photo"
	Then I should be on the New Photo page
	When I fill in "Caption" with "Tree"
	And I fill in "Tags" with "Eddy"
	And I fill in "Incidentname" with "test"
	And I fill in "Operationalperiod" with "today"
	And I fill in "Teamnumber" with "2"
	And I press "Create Photo"
	And I follow "Back"
	Then I should see "Tree"

Scenario: uploading a photo with no information
	When I follow "New Photo"
	Then I should be on the New Photo page
	And I press "Create Photo"
	Then I should see "Not enough information"
