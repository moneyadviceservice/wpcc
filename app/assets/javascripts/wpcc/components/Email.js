define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var Email,
    defaultConfig = {};

  Email = function($el, config) {
    Email.baseConstructor.call(this, $el, config, defaultConfig);

    this.$emailLink = this.$el.find('[data-dough-email-link]');
    this.$detailsHeadingSummary = this.$el.find('.details__heading .section__heading-summary');
    this.$contributionsHeadingSummary = this.$el.find('.contributions__heading .section__heading-summary');
    this.$eligibleSalary = this.$el.find('.results__eligible-salary');
    this.$resultsTables = this.$el.find('[data-dough-results-table]');
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(Email);

  Email.componentName = 'Email';

  Email.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setUpLink();
  };

  Email.prototype._setUpLink = function() {
    var message = this._getMessage();
    var href = 'mailto:?body=' + message;

    this.$emailLink.prop('href', href);
  }

  Email.prototype._getMessage = function() {
    var message = '';

    message += '1. Your details: ' + this.$detailsHeadingSummary.text() + '\n\n';
    message += '2. Your contributions: ' + this.$contributionsHeadingSummary.text() + '\n\n';
    message += '3. Results\n';
    message += 'Qualifying Earnings: ' + this.$eligibleSalary.text() + '\n\n';

    for (var i = 0, max = this.$resultsTables.length; i < max; i++) {
      message += $(this.$resultsTables.get(i)).find('.results__period-title').text() + '\n';
      message +=
        'Your contribution: ' + $(this.$resultsTables.get(i)).find('[data-dough-employee-contribution]').text() + ' ' +
        $(this.$resultsTables.get(i)).find('[data-dough-tax-relief]').text() + '\n';
      message += 'Employer\'s contribution: ' + $(this.$resultsTables.get(i)).find('[data-dough-employer-contribution]').text() + '\n';
      message += 'Total contributions: ' + $(this.$resultsTables.get(i)).find('[data-dough-total]').text();

      if (i !== max - 1) {
        message += '\n\n';
      }
    }

    return encodeURIComponent(message);
  }

  return Email;
});
