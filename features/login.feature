Feature: Log-in
	As a Bamru Member
	So I can access other features
	I want to be able to log-in

Background: A user exists
	Given a valid user exists
	And I am on the login page

Scenario: I login with the right credentials
  When I fill in 'user_email' with => 'minikermit@hotmail.com'
  And I fill in 'user_password' with => '12345678'
  And I press "Sign in"
	Then I should see "Signed in successfully."


Scenario: I login with the wrong credentials
  When I fill in 'user_email' with => 'isthislegit@awesome.com'
  And I fill in 'user_password' with => '314159265'
  And I press "Sign in"
	Then I should not see "Signed in successfully."
	And I should not be on the homepage
	And I should be on the login page
	

Scenario: I try to access features while not logged-in
	When I go to the PhotoApp homepage
	Then I should not be on the PhotoApp homepage
	And I should be on the login page
	When I go to the New Photo page
	Then I should not be on the PhotoApp homepage
	And I should be on the login page
	When I go to the Editing queue
	Then I should not be on the Editing queue
	And I should be on the login page
