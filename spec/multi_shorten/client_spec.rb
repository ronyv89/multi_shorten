require 'spec_helper'
require 'multi_shorten/client'

describe MultiShorten::Client do

	before :each do 
		subject {MultiShorten::Client.new}
	end

	describe "#shorten" do
		
		it "should return error messages if required parameters are missing" do
			expect { subject.shorten({}) }.to raise_error("Missing required parameter: url")
			expect { subject.shorten({:url => "http://www.ggogle.com"}) }.to raise_error("Missing required parameter: mode")
		end

	end


	describe "#single" do

		it "should return shortened url for a single api as specified" do
			MultiShorten::B54.stub(:shorten).with("http://www.google.com").and_return({:status => :success, :short_url => "http://b54.in/9o"})
			subject.send(:single,"b54", "http://www.google.com").should == {:status => :success, :short_url => "http://b54.in/9o"}
		end
	end

end

