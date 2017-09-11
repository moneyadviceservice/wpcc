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

    this.$emailLink = this.$el.find('[data-wpcc-email-link]');
    this.$detailsHeadingSummary = this.$el.find('[data-wpcc-details-heading-summary]');
    this.$contributionsHeadingSummary = this.$el.find('[data-wpcc-contributions-heading-summary]');
    this.$eligibleSalary = this.$el.find('[data-wpcc-eligible-salary]');
    this.$resultsTables = this.$el.find('[data-wpcc-results-table]');
    this.$frequencySelector = this.$el.find('[data-wpcc-selector]');
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(Email);

  Email.componentName = 'Email';

  Email.prototype.init = function(initialised) {
    if (this.$emailLink.length > 0) {
      this._initialisedSuccess(initialised);
      this._setUpEvents();
    }
  };

  Email.prototype._setUpEvents = function() {
    var _this = this;

    this._setUpLink();
    this.$frequencySelector.change(function() {
      _this._setUpLink();
    });
  }

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

      message += $(resultTable).find('[data-wpcc-results-period-title]').text().trim() + '\n';
      message +=
        $(resultTable).find('[data-wpcc-period-heading-yours]').text().trim() + ': ' +
        $(resultTable).find('[data-wpcc-employee-contribution]').text().trim() + ' ' +
        $(resultTable).find('[data-wpcc-tax-relief]').text().trim() + '\n';
      message +=
        $(resultTable).find('[data-wpcc-period-heading-employers]').text().trim() + ': ' +
        $(resultTable).find('[data-wpcc-employer-contribution]').text().trim() + '\n';
      message +=
        $(resultTable).find('[data-wpcc-period-heading-total]').text().trim() + ': ' +
        $(resultTable).find('[data-wpcc-total]').text().trim();

      if (i !== max - 1) {
        message += '\n\n';
      }
    }

    return encodeURIComponent(message);
  }

  return Email;
});
