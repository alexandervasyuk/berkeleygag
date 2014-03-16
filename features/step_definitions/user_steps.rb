#Successfull user registration
Given(/^I am a guest$/) do
end

When(/^I fill out the register form with valid data$/) do
  visit("/signup")
  fill_in "user_email", with:"alexander.vasyuk@berkeley.edu"
  fill_in "user_password", with:"pass"
  fill_in "user_password_confirmation", with:"pass"
  click_button "Sign up"
end

Then(/^I should be partially registered in the application$/) do
  # Yet i do not take into account partiallity
  expect(User.find_by_email("alexander.vasyuk@berkeley.edu")).not_to be_nil
end

Then(/^I should be logged in$/) do
  expect(page).to have_content("Welcome, alexander.vasyuk@berkeley.edu")
end

Then(/^I should receive confirmation email$/) do
  expect(unread_emails_for("alexander.vasyuk@berkeley.edu").size).to eq(1)
end

Then(/^I should not have access to posting photos$/) do
  pending # express the regexp above with the code you wish you had
end

# Partially registered user

Given(/^I am partially registered user$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I confirm my email$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should have access to posting photos$/) do
  pending # express the regexp above with the code you wish you had
end

# New user fills out form with invalid data

When(/^I fill out the form with invalid data$/) do
  visit("/signup")
  fill_in "user_email", with:"user@gmail.com"
  fill_in "user_password", with:"pass"
  fill_in "user_password_confirmation", with:"pass"
  click_button "Sign up"
end

Then(/^I should not be registered in the application$/) do
  expect(User.find_by_email("user@gmail.com")).to be_nil
end

Then(/^I should be presented with register form again$/) do
  expect(page).to have_selector('form#new_user')
end

Then /^I should know what went wrong$/ do
  expect(page).to have_selector("div.alert.alert-error", text:"Invalid")
end

# Authentication - login success
Given(/^reader with "(.*?)" exists$/) do |email|
  User.create(email:email, password:"pass", password_confirmation:"pass")
end

When /^I fill out the login form for "(.*?)"$/ do |email|
  visit("/signin")
  fill_in "login_email", with:email
  fill_in "login_password", with:"pass"
  click_button "Sign in"
end

Then /^I am logged in as "(.*?)"$/ do |email|
  expect(page).to have_content(email)
end

#Authentication - login failure
Given /^reader with "(.*?)" does not exist$/ do |email|
  expect(User.find_by_email(email)).to be_nil
end

Then /^I should not be logged in$/ do
  expect(page).to have_link("Sign up")
end

Then /^I should be prompted with signin form again$/ do
  expect(page).to have_selector("form#new_login")
end

Then /^I should see my errors$/ do
  expect(page).to have_selector("div.alert.alert-error", text:"Invalid email/password combination")
end
# Authentication - logout
When /^I click on signout$/ do
  click_link "Sign out"
end

Then /^I am logged out$/ do
  expect(page).not_to have_content("Welcome")
  expect(page).to have_link("Sign in")
end

#Top menu
When /^I go to home page$/ do
  visit root_url
end

Then /^I should see guest menu$/ do
  expect(page).to have_selector("#top-menu")
  expect(page).to have_link('Sign up')
  expect(page).to have_link('Sign in')
end

Given /^I am "(.*?)"$/ do |email|
  step "reader with \"#{email}\" exists"
  step "I fill out the login form for \"#{email}\""
end

Then /^I should see "(.*?)" menu$/ do |email|
  expect(page).to have_content("Welcome, #{email}")
  expect(page).to have_link("Sign out", href:signout_path)
end