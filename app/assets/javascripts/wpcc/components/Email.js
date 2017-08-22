define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var Email,
    defaultConfig = {};

  Email = function($el, config) {
    Email.baseConstructor.call(this, $el, config, defaultConfig);
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(Email);

  Email.componentName = 'Email';

  Email.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  return Email;
});
