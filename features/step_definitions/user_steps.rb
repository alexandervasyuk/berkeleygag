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
  expect(page).to have_content("To gain full priviliges, check your email")
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
  fill_in "user_password_confirmation", with:"pass1"
  click_button "Sign up"
end

Then(/^I should not be registered in the application$/) do
  expect(User.find_by_email("user@gmail.com")).to be_nil
end

Then(/^I should be presented with register form again$/) do
  expect(page).to have_selector('form#new_user')
end

Then /^I should know what went wrong$/ do
  expect(page).to have_selector("div.alert.alert-danger", text:"something went wrong")
end


#Top menu
When /^I go to home page$/ do
  visit root_url
end

Then /^I should see guest menu$/ do
  expect(page).to have_link('Sign up')
  expect(page).to have_link('Sign in')
end

Given /^I am "(.*?)"$/ do |email|
  step "user with \"#{email}\" exists"
  step "I fill out the login form for \"#{email}\""
end

Then /^I should see "(.*?)" menu$/ do |email|
  expect(page).to have_content("Welcome, #{email}")
  expect(page).to have_link("Sign out", href:signout_path)
end

#User management

When /^I visit "(.*?)" profile page$/ do |email|
  user = User.find_by_email(email)
  visit(user_path(user))
end

When /^I click "(.*?)" link$/ do |arg1|
  click_link "Edit"
end

Then /^I see the edit form for "(.*?)"$/ do |email|
  user = User.find_by_email(email)
  expect(page).to have_selector("form#edit_user_#{user.id}")
end

When /^I fill in edit form with valid data for "(.*?)"$/ do |email|
  user = User.find_by_email(email)
  visit edit_user_path(user)
  fill_in "user_password", with:"hwat"
  fill_in "user_password_confirmation", with:"hwat"
  click_button "Update"
end

Then /^I am redirected to profile page of "(.*?)"$/ do |email|
  user = User.find_by_email(email)
  expect(current_path).to eq(user_path(user))
end

Then /^I have a success notice$/ do
  expect(page).to have_content("Your profile has been updated")
end

Then /^"(.*?)" password is changed$/ do |email|
  user = User.find_by_email(email)
  expect(user.authenticate("hwat")).to eq(user)
end

Given /^I have (\d+) posts$/ do |post_number|
  user = User.find_by_email("alexander.vasyuk@berkeley.edu")
  post_number.to_i.times do
    create(:post, user:user)
  end
end


When /^I visit "(.*?)" profile$/ do |email|
  user = User.find_by_email(email)
  visit user_path(user)
end

Then /^I should see (\d+) "(.*?)" posts$/ do |num, email|
  expect(page).to have_selector(".feed_item", count:3)
end

When /^I try to access "(.*?)"$/ do |email|
  user = User.find_by_email(email)
  visit user_path(user)
end

Then /^I should be redirected to access_denied_path$/ do
  expect(current_path).to eq(access_denied_path)
end

When /^I try to access profile of user with id (\d+)$/ do |id|
  visit("/users/#{id}")
end