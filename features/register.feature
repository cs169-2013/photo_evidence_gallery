Feature: Register
	As a Bamru Member
	So I can have an account
	I want to be able to register
	
Background: A valid user exists
	Given a valid user exists
	And I am on the login page

Scenario: I register an existing account
	When I follow "Sign up"
	And I fill in "user_email" with "minikermit@hotmail.com"
	And I fill in "user_password" with "12345678"
	And I press "Sign up"
	Then I should see "Email has already been taken"
	And I should see "Email"
	And I should see "Password"
	And I should see "Password confirmation"

Scenario: I register a new account
	When I follow "Sign up"
	And I fill in "user_email" with "iamlegit@hotmail.com"
	And I fill in "user_password" with "kevincasey"
	And I fill in "user_password_confirmation" with "kevincasey"
	And I press "Sign up"
	Then I should be on the PhotoApp homepage
	And I should see "Welcome! You have signed up successfully."
	When I follow "Logout"
	Then I should be on the login page
	And I should see "Sign up"
	And I should see "Sign in"
	
Scenario: I signup with an invalid username
	When I follow "Sign up"
	And I fill in "user_email" with "thisnododps"
	And I fill in "user_password" with "kevincasey"
	And I fill in "user_password_confirmation" with "kevincasey"
	And I press "Sign up"
	And I should see "Email"
	And I should see "Password"
	And I should see "Password confirmation"
	
Scenario: I signup with an invalid password
	When I follow "Sign up"
	And I fill in "user_email" with "iamlegit@hotmail.com"
	And I fill in "user_password" with "lol"
	And I fill in "user_password_confirmation" with "lol"
	And I press "Sign up"
	Then I should see "Password is too short"

Scenario: I incorrectly type in a confirmation password
	When I follow "Sign up"
	And I fill in "user_email" with "iamlegit@hotmail.com"
	And I fill in "user_password" with "kevincasey"
	And I fill in "user_password_confirmation" with "kevinsaboss"
	And I press "Sign up"
	Then I should see "Password confirmation doesn't match Password"

