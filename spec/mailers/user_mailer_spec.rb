require 'spec_helper'

describe UserMailer do
	include EmailSpec::Matchers
  	include EmailSpec::Helpers
  	include UserMailerHelper

	describe "#confirm" do
		let(:user) {stub_model(User, email:"alexander.vasyuk@berkeley.edu", confirmation_code:"123")}
	    let(:email) {UserMailer.confirm(user)}
	    it "sets to be delivered to provided email" do
	      expect(email).to deliver_to("alexander.vasyuk@berkeley.edu")
	    end

	    it "has welcome message in the body" do
	      expect(email).to have_body_text("Welcome to BerekeleyGag")
	    end

	    it "has subject" do
	      expect(email).to have_subject("BerkeleyGag registration")
	    end

	    it "has link to confirmation" do
	    	expect(email).to have_link("Confirm your registration", href:confirm_url(user.confirmation_code))
	    end
	end
end