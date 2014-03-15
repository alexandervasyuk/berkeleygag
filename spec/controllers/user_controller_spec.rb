require 'spec_helper'

describe UsersController do
	
	describe "GET new" do
		let!(:user) {stub_model(User).as_new_record}
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

	describe "POST create" do
		let!(:user) {stub_model(User)}
		let(:params) do
			{
				"email"=>"john@berkeley.edu",
				"password"=>"pass",
				"password_confirmation"=>"pass"
			}
		end

		before :each do
			User.stub(:new).and_return(user)
		end

		it "sends new message to User class with params" do
			User.should_receive(:new).with(params)
			post :create, user:params
		end
		it "sends save message to User instance" do
			user.should_receive(:save)
			post :create, user:params
		end

		context "save message returns true" do
			before :each do
				User.stub(:save).and_return(true)
			end

			it "should redirect home" do
				post :create, user:params
				expect(response).to redirect_to root_path
			end	
		end
	end
end