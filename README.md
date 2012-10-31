README
======

Use multiple url shorteners with a single gem

Install
-------

<code>gem install multi_shorten</code>

Usage
-----
<code>
require 'multi_shorten'
client = MultiShorten::Client.new
</code>
<b>For single shortener apis</b>
<code>
client.shorten({:mode => "single", :url => "http://www.google.com", :shortener => "b54"})
</code>

<b>Sample response for this request</b>
<code>
{:status => :success, :short_url => "http://b54.in/9o"}
</code>

<b>For multiple apis</b>
<code>
client.shorten({:mode => "multiple", :url => "http://www.google.com", :shorteners => ["b54", "qr_cx"]})
</code>

<b>Sample response for this request </b>
<code>
{"b54" => {:status => :fail }, "qr_cx" => {:status => :success, :short_url => "http://qr.cx/9o"}}
</code>

Available Shortener Codes
--------------------

[b54](http://b54.in)
[linkee](http://linkee.com)
[goo_gl](http://goo.gl)
[is_gd](htpp://is.gd)
[jumbo_tweet](http://jmb.tw/)
[meta_mark](http://metamark.net)
[mt_ny](http://mtny.mobi")
[qr_cx](http://qr.cx)
[shortr](http://shortr.info)

Use the above codes to shorten your urls with the respective service
    