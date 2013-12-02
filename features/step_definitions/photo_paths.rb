
Given /the following images exist/ do |pictures_table|
  pictures_table.hashes.each do |pic|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Photo.create!(pic)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
  first = page.body.index(e1) or assert false
  second = page.body.index(e2) or assert false
  assert second > first
end

When /I upload the image "(.*)"/ do |image|
  attach_file("photo[image]", File.join(Rails.root, 'public', 'uploads', image))
end

When /I use multiple upload to upload the image "(.*)"/ do |image|
  attach_file("photos[images][]", File.join(Rails.root, 'public', 'uploads', image))
end

Then /I should see (\d+) images?/ do |count|
  assert Photo.all.length == count.to_i
end

When /I crop the image to (\d+) by (\d+)$/ do |width, height|
	find(:xpath, "//input[@id='photo_crop_x']").set "0"
	find(:xpath, "//input[@id='photo_crop_y']").set "0"
	find(:xpath, "//input[@id='photo_crop_w']").set "#{width}"
	find(:xpath, "//input[@id='photo_crop_h']").set "#{height}"
end

When /^I fill in hidden field "(.*)" with "(.*)"$/ do |field, data|
	find(:xpath, "//input[@id='#{field}']").set data
end

Then /^I should see "([^"]*)" button/ do |name|
  page.body.should have_content name
end

Then /^I should not see "([^"]*)" button/ do |name|
  page.body.should_not have_content name
end

Then /the picture's size should be (\d+) by (\d+)/ do |width, height|
	#grabs the url for the image
	page.body =~ /alt="(.+)".src="(.+)"/
	#need to check width and height of last uploaded picture.
	#debugger 
	@img = Magick::Image.read($2)[0]
	@img.inspect =~ /^.*\s(\d+)x(\d+).*$/
	assert ($1.to_i == width.to_i and $2.to_i == height.to_i), "Found the dimensions to be #{$1} by #{$2}. Full data: #{@img.inspect}"
end

Then /the picture should have the aspect ratio of (\d+\.\d+)/ do |ratio|
	#grabs the url for the image
	page.body =~ /alt="(.+)".src="(.+)"/
	#debugger
	@img = Magick::Image.read($2)[0]
	@img.inspect =~ /^.*\s(\d+)x(\d+).*$/
	assert ((($1.to_f)/($2.to_f)).round(3) == ratio.to_f), "Got #{(($1.to_f)/($2.to_f)).round(3)}, should be #{ratio.to_f}. Full data: #{@img.inspect}"
end
