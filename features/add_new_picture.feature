Feature: Upload a single image to the app

	As a photographer
	So I can add relevant photos to the database
	I want to have the database updated
	
Background: I am on the homepage
	
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage
	
Scenario: uploading a single photo
	When I follow "Upload"
	Then I should be on the New Photo page
	When I fill in "Caption" with "Tree"
	And I fill in "Tags" with "Eddy"
	And I fill in "Incident name" with "test"
	And I fill in "Operational period" with "today"
	And I fill in "Team number" with "2"
	And I upload the image "Water.jpg"
  	And I press "Create Photo"
  	And I follow "Edit"
  	And I fill in hidden field "photo_crop_x" with "100"
	And I press "Crop"
	And I am on the PhotoApp homepage
	Then I should see 1 image

Scenario: uploading a photo with no information
	When I follow "Upload"
	Then I should be on the New Photo page
	And I upload the image "Water.jpg"
	And I press "Create Photo"
	Then I should see "Successfully created photo."
