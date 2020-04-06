Wpcc::Engine.routes.draw do
  resources :your_details, only: %i[new create ]
  resources :your_contributions, only: %i[new create]
  resources :your_results, only: %i[index]

  root to: 'your_details#new', as: 'wpcc_root'
  get 'your_details/reset', to: 'your_details#reset', as: 'reset_your_detail'
end
