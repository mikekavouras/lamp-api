Rails.application.routes.draw do
  get '/ping', to: 'pages#ping'
  get '/purple', to: 'pages#purple'
end
