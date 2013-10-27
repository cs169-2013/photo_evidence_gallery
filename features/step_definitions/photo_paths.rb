
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
  attach_file(:filename, File.join(RAILS_ROOT, 'public', 'uploads', image))
end

Then /I should see ([0-9]) images?/ do |count|
  assert Photo.all.length == count
end
