require 'spec_helper'

describe User do
	let(:user) {stub_model(User)}
	before :each do
		@params = {
			email: "joe@berkeley.edu",
			password: "pass",
			password_confirmation: "pass"
		}
	end

	describe "validations" do

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

	it "has confirmation_code" do
		user.confirmation_code = "Some code"
		expect(user.confirmation_code).to eq("Some code")
	end

	it "sets confirmation_code to a randomly generated SHA1 token when user is saved" do
		user = User.new(@params)
		user.save
		expect(user.confirmation_code).not_to be_nil
	end

	it "saves changed to the user when confirm is called" do
		user = User.create(email:"alex@berkeley.edu", 
			password:"pass", password_confirmation:"pass")
		user.should_receive(:save)
		user.confirm(user.confirmation_code)
	end

	describe "#total_votes" do
		it "returns users total votes" do
			user_owner = create(:user)
			other_user = create(:user)
			post = create(:post, user:user_owner)
			post_vote = create(:post_vote, value:1, user:other_user, post:post)
			expect(user_owner.total_votes).to eq(1)
		end
	end
end