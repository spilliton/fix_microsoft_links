module FixMicrosoftLinks
  module Rack
    class Response
      def initialize(app)  
        @app = app  
      end  

      def call(env)
        # Clicking a URL from Microsoft apps will redirect you to login to already authenticated sites otherwise :(
        # http://support.microsoft.com/kb/899927
        if env["HTTP_USER_AGENT"] =~ /[^\w](Word|Excel|PowerPoint|Outlook)[^\w]/
          body = StringIO.new("<html><head><meta http-equiv='refresh' content='0'/></head><body></body></html>")
          return [200, {"Content-Type" => "text/html"}, body]
        end
        @app.call(env)
      end
    end
  end
end

# For rails 3 and greater, this will tie the fix into your middleware
require 'fix_microsoft_links/railtie' if defined?(Rails) && defined?(Rails::Railtie)

# If you are running a pre-rails 3 app you will need to do something like the following in your environment.rb:
# require 'fix_microsoft_links'
# config.middleware.insert_after Rack::Lock, FixMicrosoftLinks::Rack::Response