require 'spec_helper'

describe PostsController do
	
	describe "POST create" do

		let(:params) do
			{
				"title"=>"Some title"
			}
		end
		let!(:user) {create(:user)}
		let!(:posting) {create(:post, user:user)}
		before :each do
			sign_in user
			controller.stub(:current_user).and_return(user)
			controller.current_user.posts.stub(:build).and_return(posting)
		end

		it "sends build to current_user.posts" do
			controller.current_user.posts.should_receive(:build).with(params)
			post :create, post:params
		end
		it "sends save message to post instance" do
			posting.should_receive(:save)
			post :create, post:params
		end
		it "should assign post instance variable" do
			post :create, post: params
			expect(assigns[:post]).not_to be_nil
		end

		context "save message returns true" do

			before :each do
				posting.stub(:save).and_return(:true)
			end

			it "redirects to root url" do
				post :create, post: params
				expect(response).to redirect_to root_path
			end
		end
	end
end