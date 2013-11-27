Feature: upload multiple images

Background: I am on the homepage

  Given I am logged in as a valid user
  And I am on the PhotoApp homepage

Scenario: I upload one image
  When I follow "Multiple Upload"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	Then I should see "Multiple images uploaded"
	When I follow "Cancel"
	Then I should be on the PhotoApp homepage
	When I follow "Editing Queue"
	Then I should see 1 image
@wip
Scenario: I upload multiple images which Capybara can't do
  When I follow "Multiple Upload"
  And I upload the following images: "Water.jpg" "4985688_orig.jpg"
  And I press "Save Photos"
	Then I should see "Multiple images uploaded"
	When I follow "Cancel"
	Then I should be on the PhotoApp homepage
	When I follow "Editing Queue"
	And I should see 2 images
	
Scenario: I try to upload multiple images one by one
  When I follow "Multiple Upload"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	When I follow "Cancel"
	Then I should be on the PhotoApp homepage
	When I follow "Editing Queue"
	Then I should see 2 images

Scenario: I upload no images
  When I follow "Multiple Upload"
  And I press "Save Photos"
  Then I should see "No files chosen!"

