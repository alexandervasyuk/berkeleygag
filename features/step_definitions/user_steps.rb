Given(/^I am a guest$/) do
end

When(/^I fill out the register form with valid data$/) do
  visit("/signup")
  fill_in "user_email", with:"user@berkeley.edu"
  fill_in "user_password", with:"pass"
  fill_in "user_password_confirmation", with:"pass"
  click_button "Sign up"
end

Then(/^I should be partially registered in the application$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be logged in$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should receive confirmation email$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not have access to posting photos$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am partially registered user$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I confirm my email$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should have access to posting photos$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I fill out the form with invalid data$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not be registered in the application$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be presented with register form again$/) do
  pending # express the regexp above with the code you wish you had
end