require 'spec_helper'

describe ApplicationHelper do
	
	describe "#top_menu" do

		context "logged in" do
			let(:user) {double("User", email:"alex@berkeley.edu")}
			before :each do 
				helper.stub(:current_user).and_return(user)
			end
			it "should have welcome 'alex@berkeley.edu' text" do
				expect(helper.top_menu).to have_content("Welcome, #{user.email}")
			end
			it "should have sign out link" do
				expect(helper.top_menu).to have_link("Sign out", href:signout_path)
			end
		end

		context "not logged in" do
			before :each do 
				helper.stub(:current_user).and_return(nil)
			end
			it "should have sign up link" do
				expect(helper.top_menu).to have_link("Sign up")
			end
			it "should have sign in link" do
				expect(helper.top_menu).to have_link("Sign in")
			end
		end
	end
end