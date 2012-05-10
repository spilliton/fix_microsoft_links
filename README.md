fix_microsoft_links
===================

Experiencing redirects to login pages when a user clicks a link to your site from a Microsoft application like Word or Excel?

This gem for rails will fix that right up!  Here is some background on the issue:

If a user is already authenticated to your application in their web browser and they click a link inside MS Word to a protected URL on your application that they *should* have access to, the Microsoft application will initially provide a different cookie than the one you are already authenticated with.  This will likely cause your app to 302 the client to your app's login page.  This time the browser will be using the correct cookie, authenticate the client, and likely redirect them to whatever page your app directs users to after login.  This behavior is admitted to here: http://support.microsoft.com/kb/899927

fix_microsoft_links is rack middleware that checks the http user agent to see if the request is coming from a known Microsoft app.  If it is, it responds with a page containing only a meta refresh header tag.  Very hacky, but the easiest way around this annoyance :)

## Install 

``` ruby
# Add the following to you Gemfile
gem 'fix_microsoft_link'
# Update your bundle
bundle install
```

## Pre-Rails 3

You will need to specify in your environment.rb file where to tie the middleware into rack since you can't Railties.  Something like this should work:

``` ruby
# config/environment.rb ...
require 'fix_microsoft_links'
Rails::Initializer.run do |config|
# ....
  config.middleware.insert_after Rack::Lock, FixMicrosoftLinks::Rack::Response
# more init code....
```

## Thanks

To my employer [Moxie Software][moxiesoft], that sponsored the creation of this gem :)

[moxiesoft]: http://www.moxiesoft.com/