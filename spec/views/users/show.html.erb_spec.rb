require 'spec_helper'

describe 'users/show.html.erb' do
	subject {rendered}
	let(:user) { create(:user) }

	describe "users wall" do
		let!(:post1) {create(:post, user:user)}
		let!(:post2) {create(:post, user:user)}

		before :each do
			view.stub(:current_user?).and_return(true)
			assign(:user, user)
			assign(:posts, user.posts)
			render
		end

		it { should have_content(post1.title) }
		it { should have_content(post2.title) }
		it { should have_link("Edit", href:edit_user_path(user)) }
	end
end