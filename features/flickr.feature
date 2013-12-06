Feature: Flickr Upload
	As a Bamru member
	So I can make certain pictures public
	I want to upload pictures to Flickr from the app

Background: I am on the homepage
	Given I am logged in as a valid user
	And I follow "Upload"
	And I upload the image "Water.jpg"
	And I press "Create Photo"
	And I am on the PhotoApp homepage

Scenario: I successfully see the Flickr button
	And I follow "pic"
	And I follow "Flickr"
	Then I should upload to Flickr