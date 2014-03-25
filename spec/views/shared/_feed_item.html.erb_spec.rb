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
		expect(rendered).to have_link("haha", href:vote_post_path(post, value:1))
	end

	it "has meh button" do
		expect(rendered).to have_link("meh", href:vote_post_path(post, value:-1))
	end

	it "has count of votes" do
		expect(rendered).to have_selector(".vote-count")
	end
end