Rails.application.routes.draw do
  get 'comment/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'poll#index'
  get 'poll/index'

  post 'poll/submit'

  get 'poll/report'
  post 'poll/reward'

  post 'comment/submit'

  mount Blazer::Engine, at: "blazer"
  mount Rollout::UI::Web.new => '/admin/rollout'  
end
