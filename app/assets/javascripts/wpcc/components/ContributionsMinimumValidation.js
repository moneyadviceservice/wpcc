define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var ContributionsMinimumValidation;
  var defaultConfig = {};

  ContributionsMinimumValidation = function($el, config) {
    ContributionsMinimumValidation.baseConstructor.call(
      this,
      $el,
      config,
      defaultConfig
    );

    this.requiredMinimum = config;

    this.$employeeContribution = this.$el.find(
      '[data-wpcc-employee-contributions]'
    );
    this.$employerContribution = this.$el.find(
      '[data-wpcc-employer-contributions]'
    );
  };

  DoughBaseComponent.extend(ContributionsMinimumValidation);

  ContributionsMinimumValidation.componentName =
    'ContributionsMinimumValidation';

  ContributionsMinimumValidation.prototype.init = function(initialised) {
    this._setUpEvents();
  };

  // Set up events to detect contribution input changes
  ContributionsMinimumValidation.prototype._setUpEvents = function() {
    var $this = this;

    var validateContributionsCallback = function() {
      $this._validateContributions();
    };

    this.$employeeContribution.keyup(validateContributionsCallback);
    this.$employeeContribution.change(validateContributionsCallback);
    this.$employerContribution.keyup(validateContributionsCallback);
    this.$employerContribution.change(validateContributionsCallback);
  };

  ContributionsMinimumValidation.prototype._validateContributions = function() {
    var $this = this;
    this.$errorMessage = $('.minimum-contributions-error');
    this.$submit = $('[data-wpcc-submit]');

    if ($this._totalContributions() >= this.requiredMinimum) {
      this.$errorMessage.addClass('is-hidden');
      this.$submit.attr('disabled', false);
    } else {
      this.$errorMessage.removeClass('is-hidden');
      this.$submit.attr('disabled', true);
    }
  };

  ContributionsMinimumValidation.prototype._totalContributions = function() {
    var employeeContribution = parseFloat(this.$employeeContribution.val());
    var employerContribution = parseFloat(this.$employerContribution.val());

    return employeeContribution + employerContribution;
  };

  return ContributionsMinimumValidation;
});
