Uploader::Application.routes.draw do
  resources :uploads
  resources :apps
  root :to => "apps#index"
end
