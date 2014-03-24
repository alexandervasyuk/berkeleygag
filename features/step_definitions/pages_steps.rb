Given /^I am anyone$/ do
end

When /^I try to access a page that does not exist$/ do
  visit("/gibbberish")
end

Then /^I am redirected to a not_found_path$/ do
  expect(page).to have_content("does not exist")
end