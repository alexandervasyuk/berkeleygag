require 'spec_helper'

describe UsersController do
	let!(:user) {create(:user)}
	before :each do
		sign_in user
	end
	
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
		let(:params) do
			{
				"email"=>"alexander.vasyuk@berkeley.edu",
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

			let(:email) {double("Message", deliver:true)}
			before :each do
				user.stub(:save).and_return(true)
				UserMailer.stub(:confirm).and_return(email)
			end

			it "should redirect home" do
				post :create, user:params
				expect(response).to redirect_to root_path
			end

			it "assign success message" do
				post :create, user:params
				expect(flash[:success]).not_to be_nil
			end
			it "logs in user" do
				post :create, user:params
				expect(session[:user_id]).to eq(user.id)
			end
			it "send email with confirmation link" do
				UserMailer.should_receive(:confirm).with(user)
				email.should_receive(:deliver)
				post :create, user:params
			end
		end

		context "save message return false" do
			before :each do
				user.stub(:save).and_return(false)
			end

			it "renders new tempalte" do
				post :create, user:params
				expect(response).to render_template :new
			end
			it "assigns @user variable" do
				post :create, user:params
				expect(assigns[:user]).not_to be_nil
			end
			it "assigns error flash message" do
				post :create, user:params
				expect(flash[:error]).not_to be_nil
			end
		end
	end

	describe "GET confirm" do
		before :each do
			User.stub(:find_by_confirmation_code).and_return(user)
			user.stub(:confirm).and_return(true)
		end

		it "should find the user by its token" do
			User.should_receive(:find_by_confirmation_code).with(user.confirmation_code)
			get :confirm, token:user.confirmation_code
		end
		it "should confirm user" do
			user.should_receive(:confirm).with(user.confirmation_code)
			get :confirm, token:user.confirmation_code
		end
		it "has a flash with success" do
			get :confirm, token:user.confirmation_code
			expect(flash[:success]).not_to be_nil
		end
		it "redirects to root url" do
			get :confirm, token:user.confirmation_code
			expect(response).to redirect_to root_path
		end
	end

	describe "GET show" do
		before :each do
			User.stub(:find).and_return(user)
		end

		it "renders show template" do
			get :show, id:1
			expect(response).to render_template(:show)
		end
		it "should send User find message" do
			User.should_receive(:find).with(user.id.to_s)
			get :show, id:1
		end
		it "should send user instance posts message" do
			user.should_receive(:posts)
			get :show, id:1
		end
		it "assigns user instance" do
			get :show, id:1
			expect(assigns[:user]).not_to be_nil
		end
		it "assigns posts instance" do
			get :show, id:1
			expect(assigns[:posts]).not_to be_nil
		end

		it "redirects to signin page if user is guest" do
			session[:user_id] = nil
			get :show, id:1
			expect(response).to redirect_to(signin_url)
		end
	end

	describe "GET edit" do
		it "sends find message to User model" do
			User.should_receive(:find).with(user.id)
			get :edit, id:1
		end
		it "assigns user instance variable" do
			get :edit, id:1
			expect(assigns[:user]).not_to be_nil
		end
		it "should render edit template" do
			get :edit, id:1
			expect(response).to render_template :edit
		end
		it "redirects to signin page if user is guest" do
			session[:user_id] = nil
			get :edit, id:1
			expect(response).to redirect_to(signin_url)
		end
	end

	describe "PUT update" do
		let(:user) {create(:user, id:1)}
	    let(:params) do
	      {
	        "email" => user.email,
	        "password" => "author",
	        "password_confirmation" => "author"
	      }
	    end

	    before :each do
	      User.stub(:find).and_return(user)
	    end

	    it "sends find message" do
	      User.should_receive(:find)
	      put :update, id: user.id, user: params
	    end
	    it "sends update_attributes message with provided params" do
	      user.should_receive(:update_attributes)
	      put :update, id: user.id, user: params
	    end
	    it "redirects to signin page if user is guest" do
			session[:user_id] = nil
			put :update, id: user.id, user: params
			expect(response).to redirect_to(signin_url)
		end

	    context "when update_attributes returns true" do
	      before :each do
	        user.stub(:update_attributes).and_return(true)
	        put :update, id: user.id, user: params
	      end
	      it "redirects to user page" do
	        expect(response).to redirect_to user_path(user)
	      end
	      it "assigns flash[:notice]" do
	        expect(flash[:notice]).not_to be_nil
	      end
	    end

	    context "when update_attributes returns false" do
	      before :each do
	        user.stub(:update_attributes).and_return(false)
	        put :update, id: user.id, user: params
	      end
	      it "renders edit tempate" do
	        expect(response).to render_template :edit
	      end
	      it "assings @user variable to view" do
	        expect(assigns[:user]).to eq(user)
	      end
	      it "assings flash[:error]" do
	        expect(flash[:error]).not_to be_nil
	      end
	    end
	end
end