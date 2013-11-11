Given /^I am a new, authenticated user$/ do
	email = "fake@fake.com"
	password = "admin"
	username = "admin"
	Member.new(:email => email, :password => password, :password_confirmation => password, :username => username).save!
	
	visit root_path
	fill_in "Login", :with => username
	fill_in "Password", :with => password
	click_button "Sign in"
end

Given /^I am not authenticated$/ do
  visit destroy_member_session_path # ensure that at least
end