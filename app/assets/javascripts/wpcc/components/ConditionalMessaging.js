define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var ConditionalMessaging,
    defaultConfig = {};

  ConditionalMessaging = function($el, config) {
    ConditionalMessaging.baseConstructor.call(this, $el, config, defaultConfig);

    this.$ageField = this.$el.find('[data-wpcc-age-field]');
    this.$callout_lt16 = this.$el.find('[data-wpcc-callout-lt16]');
    this.$callout_optIn = this.$el.find('[data-wpcc-callout-optIn]');
    this.$callout_gt74 = this.$el.find('[data-wpcc-callout-gt74]');
    this.$submit = this.$el.find('[data-wpcc-submit]');
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(ConditionalMessaging);

  ConditionalMessaging.componentName = 'ConditionalMessaging';

  ConditionalMessaging.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setUpEvents();
  };

  ConditionalMessaging.prototype._setUpEvents = function() {
    var _this = this;

    this.$ageField.keyup(function() {
      _this._displayMessage();
    })
  }

  ConditionalMessaging.prototype._displayMessage = function() {
    var age = this.$ageField.val();

    this.$callout_lt16.addClass('details__callout--inactive');
    this.$callout_lt16.removeClass('details__callout--active');
    this.$callout_optIn.addClass('details__callout--inactive');
    this.$callout_optIn.removeClass('details__callout--active');
    this.$callout_gt74.addClass('details__callout--inactive');
    this.$callout_gt74.removeClass('details__callout--active');
    this.$submit.attr('disabled', false);

    if (age) {
      if (age < 16) {
        this.$callout_lt16.removeClass('details__callout--inactive');
        this.$callout_lt16.addClass('details__callout--active');
        this.$submit.attr('disabled', true);
      } else if (age > 15 && age < 22 ||
                 age > 65 && age <= 74) {
        this.$callout_optIn.removeClass('details__callout--inactive');
        this.$callout_optIn.addClass('details__callout--active');
      } else if (age >= 75) {
        this.$callout_gt74.removeClass('details__callout--inactive');
        this.$callout_gt74.addClass('details__callout--active');
        this.$submit.attr('disabled', true);
      }
    }
  }

  return ConditionalMessaging;
});
