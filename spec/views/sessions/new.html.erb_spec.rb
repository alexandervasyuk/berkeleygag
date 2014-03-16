require 'spec_helper'

describe "sessions/new.html.erb" do
	
	before :each do 
		login = mock_model("Login").as_new_record.as_null_object
		assign(:login, login)
		render
	end

	it "has login form" do
		expect(rendered).to have_selector('form#new_login')
	end
	it "has email field" do
		expect(rendered).to have_selector('#login_email')
	end
	it "has password field" do
		expect(rendered).to have_selector('#login_password')
	end	
	it "has submit button" do
		expect(rendered).to have_selector("input[type='submit']")
	end
end