require 'spec_helper'

describe UsersController do
	
	describe "GET new" do
		let!(:user) {mock_model("User").as_new_record}
		before :each do
			User.stub(:new).and_return(user)
		end
		it "should send message new to User model" do
			User.should_receive(:new)
			get :new
		end
		it "should assign @user variable" do
			get :new
			expect(assigns[:user]).not_to be_nil
		end
		it "should render new template" do
			get :new
			expect(response).to render_template(:new)
		end
	end
end