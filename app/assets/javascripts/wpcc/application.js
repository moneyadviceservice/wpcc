//= require jquery
//= require jquery_ujs
//= require require_config
//= require_self

// Components
require(['jquery', 'componentLoader'], function ($, componentLoader) {
  'use strict';

  componentLoader.init($('body'));
});
