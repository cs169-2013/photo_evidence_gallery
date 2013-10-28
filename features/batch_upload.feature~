Feature: upload multiple movies

Background: I am on the homepage

  Given I am on the PhotoApp homepage

Scenario: I upload one image
  When I follow "Multiple Uploads"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	Then I should see "multiple images uploaded"
	When I follow "Back"
	Then I should be on the PhotoApp homepage
	When I follow "Editing Queue"
	Then I should see 1 image
@wip
Scenario: I upload multiple images which Capybara can't do
  When I follow "Multiple Uploads"
  And I upload the following images: "Water.jpg" "4985688_orig.jpg"
  And I press "Save Photos"
	Then I should see "multiple images uploaded"
	When I follow "Back"
	Then I should be on the PhotoApp homepage
	When I follow "Editing Queue"
	And I should see 2 images
	
Scenario: I try to upload multiple images one by one
  When I follow "Multiple Uploads"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	And I use multiple upload to upload the image "Water.jpg"
	And I press "Save Photos"
	When I follow "Back"
	Then I should be on the PhotoApp homepage
	When I follow "Editing Queue"
	Then I should see 3 images

Scenario: I upload no images
  When I follow "Multiple Uploads"
  And I press "Save Photos"
  Then I should see "No files chosen!"

