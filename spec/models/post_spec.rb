require 'spec_helper'

describe Post do
	let(:user) {Post.new}

	it {should belong_to(:user)}
	it {should have_many(:post_votes)}

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

	describe "#votes" do
		it "returns the sum of values of all votes" do
			user1 = create(:user)
			user2 = create(:user)
			post = create(:post)
			post_vote1 = create(:post_vote, post:post, user:user1, value:1)
			post_vote2 = create(:post_vote, post:post, user:user2, value:-1)
			expect(post.votes).to eq(0)
		end
	end
end