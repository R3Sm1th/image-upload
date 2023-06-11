Rails.application.routes.draw do
  resources :posts
  get 'posts/pdf/:id', to: "posts#pdf", as: 'post_pdf'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts, except: :index
end
