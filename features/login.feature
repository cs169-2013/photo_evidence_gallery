Feature: Log-in
	As a Bamru Member
	So I can access other features
	I want to be able to log-in


Scenario: I log-in with the right credentials
	Given I am a new, authenticated user
	Then I should see "Signed in successfully."

