require 'spec_helper'

describe HomeController do

	describe "GET index" do
		context "a user is signed in " do
			let!(:user) {create(:user)}
			before :each do
				controller.stub(:signed_in?).and_return(true)
				post = create(:post, user:user)
				controller.stub(:current_user).and_return(user)
			end
			
			it "users posts should not be nil" do
				get :index
				expect(controller.current_user.posts.count).to eq(1)
			end
			it "send current_user.posts a message build" do
				controller.current_user.posts.should_receive(:build)
				get :index
			end

			it "assigns post instance variable" do
				get :index
				expect(assigns[:post]).not_to be_nil
			end
			it "assigns feed_items instance variable" do
				get :index
				expect(assigns[:feed_items]).not_to be_nil
			end

			it "renders index template" do
				get :index
				expect(response).to render_template(:index)
			end
		end

		context "a user is not signed in" do
			before :each do
				controller.stub(:signed_in?).and_return(false)
			end

			it "does not assign post instance variable" do
				get :index
				expect(assigns[:post]).to be_nil
			end
			it "does not assign feed_items instance variable" do
				get :index
				expect(assigns[:feed_items]).not_to be_nil
			end

			it "renders index template" do
				get :index
				expect(response).to render_template(:index)
			end
		end
	end
end