require 'spec_helper'

describe User do
	let(:user) {stub_model(User)}

	describe "validations" do
		before :each do
			@params = {
				email: "joe@berkeley.edu",
				password: "pass",
				password_confirmation: "pass"
			}
		end

		it { should validate_presence_of(:email) }
		it { should validate_uniqueness_of(:email) }

		it "is invalid when email is invalid" do
			@params[:email] = 'joe@gmail.com'
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
	end
	
	it "is an ActiveRecord model" do
		expect(User.superclass).to eq(ActiveRecord::Base)
	end
	it "has email" do
		user.email = "email@email.com"
		expect(user.email).to eq("email@email.com")
	end
	it "responds to password" do
		user.password = "pass"
		expect(user.password).to eq("pass")
	end
	it "responds to password_confirmation" do
		user.password_confirmation = "pass"
		expect(user.password_confirmation).to eq("pass")
	end
end