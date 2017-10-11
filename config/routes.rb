Rails.application.routes.draw do
  # Routes from gems
  devise_for :users
  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
  end
  # named routes
  root 'articles#search'
  get 'articles/results'
  # resources
  resources :articles, only: [:new, :create, :show]
  resources :publications, only: [:index, :new, :create, :show]
end
