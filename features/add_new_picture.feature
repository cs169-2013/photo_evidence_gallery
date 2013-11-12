Feature: Upload a single image to the app

	As a photographer
	So I can add relevant photos to the database
	I want to have the database updated
	
Background: I am on the homepage
	
	Given a logged in user
	Given I am on the PhotoApp homepage
	
Scenario: uploading a single photo
	When I follow "Upload"
	Then I should be on the New Photo page
	When I fill in "Caption" with "Tree"
	And I fill in "Tags" with "Eddy"
	And I fill in "Incidentname" with "test"
	And I fill in "Operationalperiod" with "today"
	And I fill in "Teamnumber" with "2"
	And I upload the image "Water.jpg"
	And I press "Create Photo"
	And I press "Crop"
	And I follow "Back"
	Then I should see 1 image

Scenario: uploading a picture from a phone with geodata
	When I follow "Upload"
	Then I should be on the New Photo page
	And I upload the image "Berkeley.jpg"
	And I press "Create Photo"
	And I press "Crop"
	Then I should see "-122.2581666666667"
	Then I should see "37.87116666666667"

Scenario: uploading a photo with no information
	When I follow "Upload"
	Then I should be on the New Photo page
	And I upload the image "Water.jpg"
	And I press "Create Photo"
	And I press "Crop"
	Then I should see "Successfully updated photo."
