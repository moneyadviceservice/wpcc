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
    var i18nStrings = this.config.i18nStrings;

    message += '1. ' + i18nStrings.detailsHeading + ': ' + this.$detailsHeadingSummary.text().trim() + '\n\n';
    message += '2. ' + i18nStrings.contributionsHeading + ': ' + this.$contributionsHeadingSummary.text().trim() + '\n\n';
    message += '3. ' + i18nStrings.resultsHeading + '\n';
    message += i18nStrings.qualifyingEarningsHeading + ': ' + this.$eligibleSalary.text().trim() + '\n\n';

    for (var i = 0, max = this.$resultsTables.length; i < max; i++) {
      var resultTable = this.$resultsTables[i];

      message += $(resultTable).find('[data-dough-results-period-title]').text().trim() + '\n';
      message +=
        $(resultTable).find('[data-dough-period-heading-yours]').text().trim() + ': ' +
        $(resultTable).find('[data-dough-employee-contribution]').text().trim() + ' ' +
        $(resultTable).find('[data-dough-tax-relief]').text().trim() + '\n';
      message +=
        $(resultTable).find('[data-dough-period-heading-employers]').text().trim() + ': ' +
        $(resultTable).find('[data-dough-employer-contribution]').text().trim() + '\n';
      message +=
        $(resultTable).find('[data-dough-period-heading-total]').text().trim() + ': ' +
        $(resultTable).find('[data-dough-total]').text().trim();

      if (i !== max - 1) {
        message += '\n\n';
      }
    }

    return encodeURIComponent(message);
  }

  return Email;
});
