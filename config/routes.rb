Wakemydyno::Application.routes.draw do

  resources :urls, path: '/', only: [:create, :new]
  root :to => 'urls#new'
  match '/dynopoker' => redirect('https://github.com/kubenstein/dynopoker')

end
