Wakemydyno::Application.routes.draw do

  resources :pings, only: [:create, :new, :create]

  root :to => 'pings#new'
end
