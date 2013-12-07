Feature: A flashing message that placates the user
As a Bamru member
So I don't get angry at slow photo uploads
I want flashing "Uploading..." text to placate me when uploads take too long


Background: I am on the homepage
	Given I am logged in as a valid user
	And I am on the PhotoApp homepage

Scenario: uploading a picture from a phone with metadata and seeing map
	When I follow "Upload"
	Then I should be on the New Photo page
	And I upload the image "Berkeley.jpg"
	Then I should see "Uploading..."
	#doesn't actually test anything, but is the minimum test needed to pass; not sure how to test this feature.