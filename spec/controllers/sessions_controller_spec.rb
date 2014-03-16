require 'spec_helper'

describe SessionsController do
	
	describe "GET new" do
		let!(:login) {mock_model("Login")}

		before :each do
			Login.stub(:new).and_return(login)
		end

		it "creates a login object" do
			Login.should_receive(:new)
			get :new
		end
		it "assigns a @login object" do 
			get :new
			expect(assigns[:login]).not_to be_nil
		end
		it "renders new template" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		let(:params) do
			{
				"email"=>"alex@berkeley.edu",
				"password"=>"pass"
			}
		end
		let!(:login) {stub_model(Login, params)}

		before :each do
			Login.stub(:new).and_return(login)
			login.stub(:authenticate).and_return(1)
			login.stub(:valid?).and_return(true)
		end

		it "sends message new to Login with params" do
			Login.should_receive(:new).with(params)
			post :create, login:params
		end


		it "sends message authenticate to the instance of login" do
			login.should_receive(:authenticate)
			post :create, login:params
		end

		context "authenticate returns true" do

			it "assings login id" do
				post :create, login:params
				expect(session[:user_id]).not_to be_nil
			end
			it "redirects to root url" do
				post :create, login:params
				expect(response).to redirect_to root_url
			end

			it "assigns login instance var" do
				post :create, login:params
				expect(assigns[:login]).not_to be_nil
			end
		
		end

		context "authenticate returns false" do
			before :each do
				login.stub(:authenticate).and_return(false)
			end
			it "assigns login instance var" do
				post :create, login:params
				expect(assigns[:login]).not_to be_nil
			end
			it "renders signin form" do
				post :create, login:params
				expect(response).to render_template(:new)
			end
			it "explains what went wrong" do
				post :create, login:params
				expect(flash[:error]).not_to be_nil
			end
		end
	end

	describe "GET destroy" do

		it "sets session[:user_id] to nil" do
			session[:user_id] = 1
			get :destroy
			expect(session[:user_id]).to be_nil
		end

		it "redirects to root url" do
			get :destroy
			expect(response).to redirect_to root_url
		end
	end
end