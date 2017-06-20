Wpcc::Engine.routes.draw do
  post 'validate_details', to: 'calculator#validate_details'
  root to: 'home#start', as: 'wpcc_root'
end
