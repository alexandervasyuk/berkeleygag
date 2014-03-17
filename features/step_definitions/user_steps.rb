#Successfull user registration
Given(/^I am a guest$/) do
end

When /^I fill out the register form with "(.*?)" valid data$/ do |email|
  visit("/signup")
  fill_in "user_email", with:email
  fill_in "user_password", with:"pass"
  fill_in "user_password_confirmation", with:"pass"
  click_button "Sign up"
end

Then /^I should be partially registered in the application with "(.*?)"$/ do |email| 
  user = User.find_by_email(email)
  expect(user).not_to be_nil
  expect(user.confirmation_code).not_to be_nil
end

Then /^I should be logged in as "(.*?)"$/ do |email|
  expect(page).to have_content("Welcome, #{email}")
end

Then /^I should receive confirmation email to "(.*?)"$/ do |email|
  expect(unread_emails_for(email).size).to eq(1)
end

Then /^I as user "(.*?)" should not have full priviliges$/ do |email|
  expect(User.find_by_email(email).confirmation_code).not_to eq("Verified")
end

# Partially registered user

Given /^I am partially registered user "(.*?)"$/ do |email|
  step "I fill out the register form with \"#{email}\" valid data"
  expect(User.find_by_email(email).confirmation_code).not_to eq("Verified")
end

Given /^I received an email at "(.*?)"$/ do |email|
  expect(unread_emails_for(email).size).to eq(1)
end

Then /^I should see "(.*?)" link in the email body$/ do |link|
  expect(current_email).to have_body_text("#{link}")
end

When /^I follow "(.*?)" link in the email body$/ do |link|
  visit_in_email(link)
end

Then /^I should have full priviliges as "(.*?)" user$/ do |email|
  expect(User.find_by_email(email).confirmation_code).to eq("Verified")
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