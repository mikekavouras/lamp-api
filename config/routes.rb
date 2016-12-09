require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.variable_size_secure_compare(username, ENV["SIDEKIQ_USERNAME"]) &
    ActiveSupport::SecurityUtils.variable_size_secure_compare(password, ENV["SIDEKIQ_PASSWORD"])
end if Rails.env.production?

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get '/ping', to: 'pages#ping'
  get '/purple', to: 'pages#purple'

  scope path: '/api', module: 'api' do
    scope path: '/v1', module: 'v1' do
      post '/oauth', to: 'oauth#create'
      post '/oauth/token', to: 'oauth#refresh'
      post '/oauth/revoke', to: 'oauth#revoke'
      get '/devices', to: 'devices#index'
      get '/devices/:id', to: 'devices#show'
      post '/devices', to: 'devices#create'
      delete '/devices/:id', to: 'devices#destroy'
      post '/devices/:id/reset', to: 'devices#reset'
    end
  end
end
