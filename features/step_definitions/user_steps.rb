Given /^a valid user exists$/ do
  @user = User.create!({
             :email => "minikermit@hotmail.com",
             :password => "12345678",
             :password_confirmation => "12345678",
             :role => "admin"
           })
end

Given /^I am logged in as a valid user$/ do
  step "a valid user exists"
  visit "/"
  fill_in "Email", :with => "minikermit@hotmail.com"
  fill_in "Password", :with => "12345678"
  click_button "Sign In"
end

Given /^another valid admin exists$/ do
  @user = User.create!({
             :email => "thelols@hotmail.com",
             :password => "12345678",
             :password_confirmation => "12345678",
             :role => "admin"
           })
end

When /^I am logged in as a valid viewer$/ do
  @user = User.create!({
             :email => "hihihihi@hotmail.com",
             :password => "12345678",
             :password_confirmation => "12345678",
             :role => "viewer"
           })
  visit "/"
  fill_in "Email", :with => "hihihihi@hotmail.com"
  fill_in "Password", :with => "12345678"
  click_button "Sign In"
end
