require 'sidekiq/web'

Rails.application.routes.draw do
  root 'poll#index'
  get 'poll/index'
  post 'poll/index'

  get 'poll/report'

  mount Sidekiq::Web => '/sidekiq'
end
