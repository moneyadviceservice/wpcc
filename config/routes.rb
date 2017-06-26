Wpcc::Engine.routes.draw do
  resources :your_details, only: [:new, :create]
  resources :your_contributions, only: [:new, :create]

  root to: 'your_details#new', as: 'wpcc_root'
end
