require 'spec_helper'

describe Login do
	let(:login) {Login.new}

	describe "#authenticate" do
		let!(:user) { User.create(email:"alex@berkeley.edu", password:"pass", password_confirmation:"pass") }
		
		it "returns user_id if credentials are valid" do
			login = Login.new(email:user.email, password:user.password)
			expect(login.authenticate).to eq(user.id)
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