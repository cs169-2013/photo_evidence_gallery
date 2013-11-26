Feature: Log-in
	As a Bamru Member
	So I can keep track of where photos were taken
	I want to be able to see a map with push-pins in the locations where photos were taken

Background: I am on the homepage
	
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage

Scenario: uploading a picture from a phone with metadata and seeing map
	When I follow "Upload"
	Then I should be on the New Photo page
	And I upload the image "Berkeley.jpg"
	And I press "Create Photo"
	Then I should see "-122.2581666666667"
	Then I should see "37.87116666666667"
	Then I should see "2013:09:21 13:09:39"
	And I am on the PhotoApp homepage
    Then I should see "Map of locations" button

Scenario: Button doesn't appear for no pictures
	And I am on the PhotoApp homepage
	Then I should not see "Map of locations" button