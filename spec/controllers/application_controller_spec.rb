require 'spec_helper'

describe ApplicationController do
	
	describe "#current_user" do
		it "returns nil if user is not logged in" do
			session[:user_id] = nil
			expect(controller.current_user).to be_nil
		end	
		it "returns user id if user id logged in" do
			user = User.create(id:1, email:"alex@berkeley.edu", password:"pass", password_confirmation:"pass")
			session[:user_id] = user.id
			expect(controller.current_user).to eq(user)
		end
	end
end