require 'spec_helper'

describe UserMailer do
	include EmailSpec::Matchers
  	include EmailSpec::Helpers

	describe "#confirm" do
	    let(:email) {UserMailer.confirm("alexander.vasyuk@berkeley.edu")}
	    it "sets to be delivered to provided email" do
	      expect(email).to deliver_to("alexander.vasyuk@berkeley.edu")
	    end

	    it "has welcome message in the body" do
	      expect(email).to have_body_text("Welcome to BerekeleyGag")
	    end

	    it "has subject" do
	      expect(email).to have_subject("BerkeleyGag registration")
	    end
	end
end