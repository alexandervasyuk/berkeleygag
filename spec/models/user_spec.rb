require 'spec_helper'

describe User do
	let(:user) {stub_model(User)}
	
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