## Configure Rack CORS Middleware, so that CloudFront can serve our assets.
## See https://github.com/cyu/rack-cors

if defined? Rack::Cors
  Rails.configuration.middleware.insert_before 0, Rack::Cors do
      allow do
          origins %w[
              https://news.ink-stream.com
              http://news.ink-stream.com
          ]
          resource '/assets/*'
      end
  end
end