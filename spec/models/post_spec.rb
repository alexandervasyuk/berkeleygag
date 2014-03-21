require 'spec_helper'

describe Post do
	let(:user) {Post.new}

	describe "validations" do

		it { should validate_presence_of(:title) }
	end

	it "is an ActiveRecord model" do
		expect(User.superclass).to eq(ActiveRecord::Base)
	end

	it "has title" do
		user.title = "Some title"
		expect(user.title).to eq("Some title")
	end
end