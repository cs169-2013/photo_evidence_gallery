Feature: edit or delete existing photos

	As a browser through the site
	So I can edit or remove photos from the database
	I want to have the database updated with all current and relevant info
	
Background: I am on the homepage
	
	Given the following images exist:
  |caption    |tags |incidentName 	|operationalPeriod|teamNumber |contentType	|filename   |edited |
  |Tree       |a    |Kevin					|January			  	|team 2			|what			 		|tree.jpg   |true		|
	And I am on the PhotoApp homepage
	
Scenario: Editing a photo
	Given I am a new, authenticated user
	When I follow "Edit"
	When I fill in "incidentName" with "Craig"
	And I press "Update Photo"
	Then I should see "Craig"
	When I follow "Back"
	Then I should be on the PhotoApp homepage

Scenario: Deleting a photo
	Given I am a new, authenticated user
	When I follow "Destroy"
	Then I should be on the PhotoApp homepage
	And I should see 0 images
