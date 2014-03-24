require 'spec_helper'

describe "shared/_feed_item.html_spec.rb" do
	let(:post) {create(:post)}

	before :each do
		render partial:"shared/feed_item", locals:{feed_item:post}
	end	

	it "has title" do
		expect(rendered).to have_content(post.title)
	end

	it "has timestamp" do
		expect(rendered).to have_content(time_ago_in_words(post.created_at))	
	end

	it "has haha button" do
		expect(rendered).to have_link("haha")
	end

	it "has meh button" do
		expect(rendered).to have_link("meh")
	end
end