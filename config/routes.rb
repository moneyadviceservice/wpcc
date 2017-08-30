Wpcc::Engine.routes.draw do
  resources :your_details, only: %i[new create destroy]
  resources :your_contributions, only: %i[new create]
  resources :your_results, only: %i[index]

  root to: 'your_details#new', as: 'wpcc_root'
end
