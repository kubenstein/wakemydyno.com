Wakemydyno::Application.routes.draw do

  resources :urls, only: [:create, :new]

  root :to => 'urls#new'
end
