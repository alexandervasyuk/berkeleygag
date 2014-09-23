# Authentication - login success
Given(/^user with "(.*?)" exists$/) do |email|
  User.create(email:email, password:"pass", password_confirmation:"pass", confirmation_code:"Verified")
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
Given /^user with "(.*?)" does not exist$/ do |email|
  expect(User.find_by_email(email)).to be_nil
end

Then /^I should not be logged in$/ do
  expect(page).to have_link("Sign up")
end

Then /^I should be prompted with signin form again$/ do
  expect(page).to have_selector("form#new_login")
end

Then /^I should see my errors$/ do
  expect(page).to have_selector("div.alert.alert-danger", text:"Invalid email/password combination")
end
# Authentication - logout
When /^I click on signout$/ do
  click_link "Sign out"
end

Then /^I am logged out$/ do
  expect(page).to have_link("Sign in")
end

#Authentication unsigned out access

When /^I access a page that requires login$/ do
  user = create(:user)
  visit(user_path(user.id))
end

Then /^I should be redirected to sign in page$/ do
  expect(current_path).to eq(signin_path)
  expect(page).to have_content("Please sign in first")
end