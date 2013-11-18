Then(/^I should get download with the filename "(.*?)"$/) do |arg1|
  page.drive.response.headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end

When(/^I upload the file "(.*?)"$/) do |file|
  attach_file(:csv_file, File.join(RAILS_ROOT, 'features', 'upload-files', file))
end

When(/^I log in as "(.*?)" and password "(.*?)"$/) do |email, password|
  visit signin_url
  fill_in "user_email", :with => email
  fill_in "user_password", :with => "password"
  click_button "Sign in"
end
