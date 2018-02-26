Rottenpotatoes::Application.routes.draw do
  resources :movies
  get 'movies/:id/movies_by_the_same_director', to: 'movies#same_director', as: :same_director
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
