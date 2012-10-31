# README


Use multiple url shorteners with a single gem

## Installation

  <code>gem install multi_shorten</code>

## Usage

#### Require the gem
  <code>require 'multi_shorten'</code>

#### Instantiate the client
  <code>client = MultiShorten::Client.new</code>

#### For single shortener apis
  <code>client.shorten({:mode => "single", :url => "http://www.google.com", :shortener => "b54"})</code>


#### Sample response for this request
  <code>
  {:status => :success, :short_url => "http://b54.in/9o"}
  </code>

#### For multiple apis
  <code>
  client.shorten({:mode => "multiple", :url => "http://www.google.com", :shorteners => ["b54", "qr_cx"]})
  </code>

#### Sample response for this request
  <code>
  {"b54" => {:status => :fail }, "qr_cx" => {:status => :success, :short_url => "http://qr.cx/9o"}}
  </code>

## Available Shortener Codes


[b54](http://b54.in)<br/>
[linkee](http://linkee.com)<br/>
[goo_gl](http://goo.gl)<br/>
[is_gd](htpp://is.gd)<br/>
[jumbo_tweet](http://jmb.tw/)<br/>
[meta_mark](http://metamark.net)<br/>
[mt_ny](http://mtny.mobi")<br/>
[qr_cx](http://qr.cx)<br/>
[shortr](http://shortr.info)<br/>

Use the above codes to shorten your urls with the respective service
    