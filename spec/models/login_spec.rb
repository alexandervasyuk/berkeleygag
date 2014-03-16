require 'spec_helper'

describe Login do
	let(:login) {Login.new}

	describe "#authenticate" do
		before :each do
			User.create(id:1, email:"alex@berkeley.edu", password:"pass", password_confirmation:"pass")
		end
		it "returns user_id if credentials are valid" do
			login = Login.new(email:"alex@berkeley.edu", password:"pass")
			expect(login.authenticate).to eq(1)
		end
		it "returns nil if email is invalid" do
			login = Login.new(email:"alex@gmail.com", password:"pass")
			expect(login.authenticate).to eq(nil)
		end
		it "returns nil if " do
			login = Login.new(email:"alex@berkeley.edu", password:"passs")
			expect(login.authenticate).to eq(nil)
		end
	end
	
	context "attributes" do
		it "has email" do
			login.email = "user@berkeley.edu"
			expect(login.email).to eq("user@berkeley.edu")
		end
		it "has password" do
			login.password = "pass"
			expect(login.password).to eq("pass")
		end
	end
end