require 'spec_helper'
require 'multi_shorten/url_shorteners'

describe MultiShorten::B54 do

  before :each do
    subject { MultiShorten::B54.new }
  end

  it "should stub" do
    stub_request(:get, "http://b54.in/api/?action=shorturl&format=json&url=http://www.google.com").
         to_return(:status => 200, :body => '{"status":"fail","code":"error:url","message":"http:\/\/www.google.com already exists in database","shorturl":"http:\/\/b54.in\/9o","statusCode":200}', :headers => {})
    subject.shorten("http://www.google.com").should == { :status => :success, :short_url => "http://b54.in/9o"}
  end
end
