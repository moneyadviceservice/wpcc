# Add additional assets to the asset load path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  application.css
  dough/assets/js/components/DoughBaseComponent.js
  dough/assets/js/lib/componentLoader.js
  jquery/dist/jquery.js
  requirejs/require.js
  rsvp/rsvp.js)
