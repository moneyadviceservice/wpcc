define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var ConditionalMessaging,
    defaultConfig = {};

  ConditionalMessaging = function($el, config) {
    ConditionalMessaging.baseConstructor.call(this, $el, config, defaultConfig);

    this.$ageField = this.$el.find('[data-dough-age-field]');
    this.$genderSelect = this.$el.find('[data-dough-gender-select]');
    this.$callout_lt16 = this.$el.find('[data-dough-callout-lt16]');
    this.$callout_optIn = this.$el.find('[data-dough-callout-optIn]');
    this.$callout_gt74 = this.$el.find('[data-dough-callout-gt74]');
    this.$submit = this.$el.find('[data-dough-submit]');
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

    this.$genderSelect.change(function() {
      _this._displayMessage();
    })
  }

  ConditionalMessaging.prototype._displayMessage = function() {
    var age = this.$ageField.val();
    var gender = this.$genderSelect.val();

    this.$callout_lt16.addClass('details__callout--inactive');
    this.$callout_optIn.addClass('details__callout--inactive');
    this.$callout_gt74.addClass('details__callout--inactive');
    this.$submit.attr('disabled', false);

    if (age && gender) {
      if (age < 16) {
        this.$callout_lt16.removeClass('details__callout--inactive');
        this.$callout_lt16.addClass('details__callout--active');
        this.$submit.attr('disabled', true);
      } else if (age > 15 && age < 22 || 
                 age > 64 && age <= 74 && gender == 'male' || 
                 age > 63 && age <= 74 && gender == 'female') {
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
