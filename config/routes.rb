Wakemydyno::Application.routes.draw do

  resources :urls, only: [:create, :new, :create]

  root :to => 'urls#new'
end
