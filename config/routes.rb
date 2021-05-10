Rails.application.routes.draw do
  root 'poll#index'
  get 'poll/index'
  post 'poll/index'

  get 'poll/summary'
end
