define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var BlankTest,
      defaultConfig = {};

  BlankTest = function($el, config) {
    BlankTest.baseConstructor.call(this, $el, config, defaultConfig);
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(BlankTest);

  BlankTest.componentName = 'BlankTest';

  BlankTest.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  return BlankTest;
});
