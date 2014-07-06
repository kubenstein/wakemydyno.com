Wakemydyno::Application.routes.draw do

  resources :urls, path: '/', only: [:create, :new]
  root :to => 'urls#new'

end
