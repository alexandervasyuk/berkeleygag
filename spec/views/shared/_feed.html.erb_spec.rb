require 'spec_helper'

describe "shared/_feed.html.erb" do
	let(:post) {create(:post)}
	before :each do
		feed_items = [post]
		assign(:feed_items, feed_items)
		render
	end

	it "has feed" do
		expect(rendered).to have_selector(".posts")
	end
	it "should have two feed items" do
		expect(rendered).to have_selector(".feed_item", count:1)
	end
	it "has title" do
		expect(rendered).to have_content(post.title)
	end
	it "has timestamp" do
		expect(rendered).to have_content(time_ago_in_words(post.created_at))
	end
end