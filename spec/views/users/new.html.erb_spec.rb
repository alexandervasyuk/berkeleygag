require 'spec_helper'

describe "users/new.html.erb" do
	before :each do
		user = mock_model("User")
		assign(:user, user).as_new_record.as_null_object
		render
	end

	it "has new_user form" do
		expect(rendered).to have_selector("form#new_user")
	end

	it "has new_user email field" do
		expect(rendered).to have_selector("#user_email")
	end

	it "has new_user password field" do
		expect(rendered).to have_selector("#user_password")
	end	

	it "has new_user password_confirmation field" do
		expect(rendered).to have_selector("#user_password_confirmation")
	end

	it "has signup button" do
		expect(rendered).to have_selector('input[type="submit"]')
	end
end