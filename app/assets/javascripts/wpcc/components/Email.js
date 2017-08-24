define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var Email,
    defaultConfig = {
      i18nStrings: {
        detailsHeading: 'Your details',
        contributionsHeading: 'Your contributions',
        resultsHeading: 'Your Results',
        qualifyingEarningsHeading: 'Qualifying earnings'
      }
    };

  Email = function($el, config) {
    Email.baseConstructor.call(this, $el, config, defaultConfig);

    this.$emailLink = this.$el.find('[data-dough-email-link]');
    this.$detailsHeadingSummary = this.$el.find('[data-dough-details-heading-summary]');
    this.$contributionsHeadingSummary = this.$el.find('[data-dough-contributions-heading-summary]');
    this.$eligibleSalary = this.$el.find('[data-dough-eligible-salary]');
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

    message += '1. ' + this.config.i18nStrings.detailsHeading + ': ' + this.$detailsHeadingSummary.text() + '\n\n';
    message += '2. ' + this.config.i18nStrings.contributionsHeading + ': ' + this.$contributionsHeadingSummary.text() + '\n\n';
    message += '3. ' + this.config.i18nStrings.resultsHeading + '\n';
    message += this.config.i18nStrings.qualifyingEarningsHeading + ': ' + this.$eligibleSalary.text() + '\n\n';

    for (var i = 0, max = this.$resultsTables.length; i < max; i++) {
      message += $(this.$resultsTables.get(i)).find('[data-dough-results-period-title]').text() + '\n';
      message +=
        $(this.$resultsTables.get(i)).find('[data-dough-period-heading-yours]').text() + ': ' +
        $(this.$resultsTables.get(i)).find('[data-dough-employee-contribution]').text() + ' ' +
        $(this.$resultsTables.get(i)).find('[data-dough-tax-relief]').text() + '\n';
      message +=
        $(this.$resultsTables.get(i)).find('[data-dough-period-heading-employers]').text() + ': ' +
        $(this.$resultsTables.get(i)).find('[data-dough-employer-contribution]').text() + '\n';
      message +=
        $(this.$resultsTables.get(i)).find('[data-dough-period-heading-total]').text() + ': ' +
        $(this.$resultsTables.get(i)).find('[data-dough-total]').text();

      if (i !== max - 1) {
        message += '\n\n';
      }
    }

    return encodeURIComponent(message);
  }

  return Email;
});
