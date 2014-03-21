require 'spec_helper'

describe SessionsHelper do
		
	describe "#current_user" do
		it "returns nil if user is not logged in" do
			session[:user_id] = nil
			expect(helper.current_user).to be_nil
		end	
		it "returns user id if user id logged in" do
			user = User.create(id:1, email:"alex@berkeley.edu", password:"pass", password_confirmation:"pass")
			session[:user_id] = user.id
			expect(helper.current_user).to eq(user)
		end
	end

	describe "#current_user?" do

		it "returns false if user is not current_user" do
			session[:user_id] = 1
			user = create(:user, id:1)
			user = create(:user, id:2)
			expect(helper.current_user?(user)).to be_false
		end
		it "returns true if user is current_user" do
			session[:user_id] = 1
			user = create(:user, id:1)
			expect(helper.current_user?(user)).to be_true
		end
	end

	describe "#signed_in?" do
		it "returns false if no one is signed in" do
			session[:user_id] = nil
			expect(helper.signed_in?).to be_false
		end
	end
end