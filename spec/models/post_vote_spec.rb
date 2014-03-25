require 'spec_helper'

describe PostVote do
	let(:user) {create(:user)}
	let(:post) {create(:post, user:user)}
	let(:post_vote) {stub_model(PostVote, user_id:user.id, post_id:post.id, value:1)}

	before :each do
		PostVote.any_instance.stub(:post).and_return(post)
	end

	describe "validations" do
		it { should validate_uniqueness_of(:post_id).scoped_to(:user_id) }
		it { should ensure_inclusion_of(:value).in_array([1, -1])}
		it "is invalid when author votes on his post" do
			post_vote = PostVote.new(user_id:user.id, post_id:post.id, value:1)
			expect(post_vote.valid?).to be_false
		end
	end

	it { should belong_to(:user) }
	it { should belong_to(:post) }
	
	it "is an ActiveRecord model" do
		expect(PostVote.superclass).to eq(ActiveRecord::Base)
	end
	it "has user_id" do
		post_vote.user_id = 1
		expect(post_vote.user_id).to eq(1)
	end
	it "has post_id" do
		post_vote.post_id = 1
		expect(post_vote.post_id).to eq(1)
	end
	it "has value" do
		post_vote.value = 1
		expect(post_vote.value).to eq(1)
	end
	it "responds to user" do
		post_vote.user = user
		expect(post_vote.user).to eq(user)
	end
	it "responds to post" do
		post_vote.post = post
		expect(post_vote.post).to eq(post)
	end
end