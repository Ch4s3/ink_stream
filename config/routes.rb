Rails.application.routes.draw do
  devise_for :users
  root 'articles#search'
  get 'articles/results'
  resources :articles, only: [:new, :create, :show]
  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
  end
end
