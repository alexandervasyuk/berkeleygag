require 'spec_helper'

describe "posts/_post.html.erb" do
	let(:post) { create(:post) }
	
	before :each do
		view.stub(:current_user?).and_return(true)
		render partial:"posts/post", locals:{post:post}
	end

	it "should have title" do
		expect(rendered).to have_content(post.title)
	end
	it "should have photo"

	context "user is the owner" do
		it "should have delete link" do
			expect(rendered).to have_link("delete", href:post_path(post))
		end
	end
end