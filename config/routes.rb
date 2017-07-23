# config/routes.rb
Rails.application.routes.draw do
  resources :accommodations

  resources :students_halls

  resources :notices
end