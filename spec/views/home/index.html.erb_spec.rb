require 'spec_helper'

describe "home/index.html.erb" do

	context "a user is not signed in" do
		before :each do
			view.stub(:signed_in?).and_return(false)
			assign(:feed_items, Post.by_votes_freshest.page(params[:page]).per_page(3))
			render
		end
		it "does not have the post form" do
			expect(rendered).not_to have_selector("form#new_post")
		end
		it "has posts feed" do
			expect(rendered).to have_selector("#feed")
		end
	end

	context "a user is signed in" do
		let(:post){stub_model(Post).as_new_record}
		let(:user){stub_model(User, id:1)}
		before :each do
			view.stub(:signed_in?).and_return(true)
			assign(:post, post)
			assign(:feed_items, Post.by_votes_freshest.page(params[:page]).per_page(3))
			render 
		end
		it "has post form" do
			expect(rendered).to have_selector("form#new_post")
		end
		it "has posts feed" do
			expect(rendered).to have_selector("#feed")
		end
	end
end