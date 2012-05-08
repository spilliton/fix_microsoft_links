module FixMicrosoftLinks
  class Railtie < Rails::Railtie
    initializer 'fix_microsoft_links.register_middleware' do |app|
      app.config.middleware.insert_after ::Rack::Lock, FixMicrosoftLinks::Rack::Response
    end
  end
end
