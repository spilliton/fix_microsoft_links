module FixMicrosoftLinks
  class Railtie < Rails::Railtie
    initializer 'fix_microsoft_links.register_middleware' do |app|
      app.config.middleware.use FixMicrosoftLinks::Rack::Response
    end
  end
end
