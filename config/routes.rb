Wakemydyno::Application.routes.draw do

  resources :pings

  root :to => 'pings#index'
end
