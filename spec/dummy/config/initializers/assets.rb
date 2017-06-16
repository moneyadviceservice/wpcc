Rails.application.configure do
  
  config.assets.paths << Rails.root.join('..', '..', 'vendor', 'assets', 'bower_components')

  # Application JavaScript
  config.assets.precompile += %w(dough/assets/js/lib/*.js
                                 dough/assets/js/components/*.js)
end
