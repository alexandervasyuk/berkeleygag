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

	describe "#owned_by?" do

		it "returns true if post is owned by provided user" do
			owner = create(:user,id:1)
			post = create(:post, user:owner)
			expect(post.owned_by?(owner)).to eq(true)
		end
		it "returns false if post is not owned by provided user" do
			user = create(:user)
			post = create(:post)
			expect(post.owned_by?(user)).to eq(false)
		end
	end
end