//= require require_config

require(['wpccConfig'], function() {
  require(['componentLoader'], function (componentLoader) {
    componentLoader.init($('body'));
  });
});
