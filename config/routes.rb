Hush::Application.routes.draw do
  resources :secrets, :only => [:create, :new, :show]
end
