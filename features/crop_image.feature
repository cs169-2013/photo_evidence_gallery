
Feature: crop photos with different masks

Background: I am on a page of a photo. 
	
	Given I am logged in as a valid user
	And I am on the New Photo page
	And I upload the image "Water.jpg"
	And I fill in "Caption" with "Photoname"
  And I press "Create Photo"
	
Scenario: use a custom crop
	When I crop the image to 400 by 200
	Then I press "Crop"
	Then I should see "Photoname"
	And the picture's size should be 400 by 200

Scenario: use a square mask
	When I press "Crop"
	Then I should see "Photoname"
	And the picture should have the aspect ratio of 1.000

Scenario: use a portrait mask
	When I choose "portrait"
	And I press "Crop"
	Then I should see "Photoname"
	And the picture should have the aspect ratio of 0.618

Scenario: use a landscape mask
	When I choose "landscape"
	And I press "Crop"
	Then I should see "Photoname"
	And the picture should have the aspect ratio of 1.618

