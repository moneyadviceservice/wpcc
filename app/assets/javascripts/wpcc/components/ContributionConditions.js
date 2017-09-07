define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var ContributionConditions,
  defaultConfig = {};

  ContributionConditions = function($el, config) {
    ContributionConditions.baseConstructor.call(this, $el, config, defaultConfig);

    this.$employeeContributions = this.$el.find('[data-dough-employee-contributions]');
    this.$eligibleSalary = this.$el.find('[data-dough-contribution-salary]');
    this.$contributionWarning = this.$el.find('[data-dough-callout-contribution-gt40000]');

  };

  DoughBaseComponent.extend(ContributionConditions);

  ContributionConditions.componentName = 'ContributionConditions';

  ContributionConditions.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._calculateContribution();
    this._setUpEvents();
  };

  // Set up events to detect contribution input changes
  ContributionConditions.prototype._setUpEvents = function() {
    var $this = this;

    var contributionsCallback = function() {
      $this._calculateContribution();
    };

    this.$employeeContributions.keyup(contributionsCallback);
    this.$employeeContributions.change(contributionsCallback);

  }

  //add up employee contributions based on salary
  //if more than 40k call display function otherwise call the hide function
  ContributionConditions.prototype._calculateContribution = function() {
    var $this = this,
    salaryNumber = this.$eligibleSalary.text().replace(/[£,]/g, ''),
    salaryToNumber = parseInt(salaryNumber),
    salaryContributionAmount = (salaryToNumber/100)*this.$employeeContributions.val();
    
    if (salaryContributionAmount > 40000) {
      $this._displayMessage();
    }
    else {
      $this._hideMessage();
    }

  }

  //display warning message
  ContributionConditions.prototype._displayMessage = function() {

    this.$contributionWarning.removeClass('details__callout--inactive');
    this.$contributionWarning.addClass('details__callout--active');

  };

  //hide warning message
  ContributionConditions.prototype._hideMessage = function() {

    this.$contributionWarning.removeClass('details__callout--active');
    this.$contributionWarning.addClass('details__callout--inactive');

  };

  return ContributionConditions;
});
