require 'spec_helper'

describe PostsController do
	
	describe "POST create" do

		let(:params) do
			{
				"title"=>"Some title",
				"remote_photo_url"=>"http://i.memeful.com/meme/something.jpg"
			}
		end
		let!(:user) {create(:user, confirmation_code:"Verified")}
		let!(:posting) {create(:post, user:user)}
		before :each do
			sign_in user
			controller.stub(:current_user).and_return(user)
			controller.current_user.posts.stub(:build).and_return(posting)
		end

		it "sends build to current_user.posts" do
			controller.current_user.posts.should_receive(:build).with(params)
			@request.env['HTTP_REFERER'] = root_path
			post :create, post:params
		end
		it "sends save message to post instance" do
			posting.should_receive(:save)
			@request.env['HTTP_REFERER'] = root_path
			post :create, post:params
		end
		it "should assign post instance variable" do
			@request.env['HTTP_REFERER'] = root_path
			post :create, post: params
			expect(assigns[:post]).not_to be_nil
		end

		context "save message returns true" do

			before :each do
				posting.stub(:save).and_return(:true)
			end

			it "redirects to root url" do
				@request.env['HTTP_REFERER'] = root_path
				post :create, post: params
				expect(response).to redirect_to root_path
			end
		end
	end

	describe "DELETE destroy" do
		let(:user) {create :user, confirmation_code:"Verified"}
		let(:post) {create :post, user:user}

		before :each do
			Post.stub(:find).and_return(post)
			post.stub(:owned_by?).and_return(true)
		end

		it "sends find" do
			Post.should_receive(:find).with(post.id.to_s)
			@request.env['HTTP_REFERER'] = 'http://localhost:3000'
			delete :destroy, id:post.id
		end

		context "when user is the owner" do
			before :each do
				post.stub(:owned_by?).and_return(true)
			end

			it "sends destroy msg" do
				post.should_receive(:destroy)
				@request.env['HTTP_REFERER'] = root_path
				delete :destroy, id:post.id
			end

			it "redirect_to users path" do
				@request.env['HTTP_REFERER'] = user_path(user)
				delete :destroy, id:post.id
				expect(response).to redirect_to user_path(user)
			end
		end

		context "when user is not the owner" do
			before :each do
				post.stub(:owned_by?).and_return(false)
			end

			it "redirects to access denied page" do
				delete :destroy, id:post.id
				expect(response).to redirect_to access_denied_path
			end
		end
	end

	describe "POST vote" do

		let(:user) {create(:user, confirmation_code:"Verified")}
		let(:posting) {create(:post, user:user)}
		let(:post_vote) {mock_model("PostVote").as_null_object}
		before :each do
			controller.stub(:current_user).and_return(user)
			controller.current_user.stub(:post_votes).and_return(double("Object"))
			controller.current_user.post_votes.stub(:build).and_return(post_vote)
			request.env["HTTP_REFERER"] = root_url
		end
		it "sends a new message to current_user.post_votes" do
			controller.current_user.post_votes.should_receive(:build)
			post :vote, id:posting.id, value:1
		end

		it "send a save message" do
			post_vote.should_receive(:save)
			post :vote, id:posting.id, value:1
		end

		it "redirects back" do
			post :vote, id:posting.id, value:1
			expect(response).to redirect_to(:back)
		end

		context "save returns true" do
			before :each do
				post_vote.stub(:save).and_return(true)
			end

			it "should have notice thanks" do
				post :vote, id:posting.id, value:1
				expect(flash[:notice]).not_to be_nil
			end
		end

		context "save returns false" do
			before :each do
				post_vote.stub(:save).and_return(false)
			end

			it "should have notice thanks" do
				post :vote, id:posting.id, value:1
				expect(flash[:error]).not_to be_nil
			end
		end
	end	
end