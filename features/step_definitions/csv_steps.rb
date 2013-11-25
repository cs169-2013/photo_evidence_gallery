When(/^I upload the file "(.*?)"$/) do |file|
  attach_file(:csv_file, File.join(Rails.root, 'features', 'upload-files', file))
end

When(/^I log in as "(.*?)" and password "(.*?)"$/) do |email, password|
  visit '/'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Then /^I should get a download with the filetype "([^\"]*)"$/ do |filename|
    page.response_headers["Content-Type"].should include("#{filename}") unless @selenium
end
