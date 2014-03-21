require 'spec_helper'

describe "shared/_post_form.html.erb" do

	before :each do
		post = mock_model("Post").as_new_record.as_null_object
		assign(:post, post)
		render
	end
	it "has photo upload field" do
		expect(rendered).to have_selector("#post_photo")
	end
	it "has url field"
	it "should have title field" do
		expect(rendered).to have_selector("input#post_title")
	end
	it "should have submit button" do
		expect(rendered).to have_selector("input[type='submit']")
	end
end