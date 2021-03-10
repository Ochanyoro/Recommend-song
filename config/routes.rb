Rails.application.routes.draw do
  devise_for :users

  resources :posts
  resources :profiles,only:[:show,:new,:edit,:update,:create]
  resources :messages,only:[:show,:new,:edit,:update,:create,:destroy]
  resources :singers, only:[:index,:show,:new,:create]

  root 'posts#index'
  get 'top/show'
  get "posts/:id/comment" => "posts#comment"
  post "likes/:id/post"    => "likes#create"
  post "likes/:id/destroy" => "likes#destroy"
  post "likes/:id/post2"   => "likes#create2"
  post "likes/:id/destroy2"=> "likes#destroy2"
  post "likes/:id/post3"   => "likes#create3"
  post "likes/:id/destroy3"=> "likes#destroy3"
  post "messages/:id/love" => "messages#love"
  post "messages/:id/bad"  => "messages#bad"
  post "messages/:id/delete"=>"messages#delete"
end
