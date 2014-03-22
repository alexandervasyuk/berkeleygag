require 'spec_helper'

describe ApplicationController do

	controller do
		def index 
			raise AccessDenied
		end
	end

	describe "#access_denied" do
		it "should redirect to access_denied_path" do
			get :index
			expect(response).to redirect_to access_denied_path
		end
	end
end