Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://example.com'  # You might want to specify specific origins instead of allowing all
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
end
