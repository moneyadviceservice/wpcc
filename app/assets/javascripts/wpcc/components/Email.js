define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var Email,
    defaultConfig = {};

  Email = function($el, config) {
    Email.baseConstructor.call(this, $el, config, defaultConfig);

    this.$emailLink = this.$el.find('[data-dough-email-link]');
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

    message += '1. Your details: 31 years, male, £50,000 per year, part salary\n\n';
    message += '2. Your contributions: You: 1%, Your employer: 1%\n\n';
    message += '3. Results: Qualifying Earnings: £39,124\n\n';
    message += 'Now\n';
    message += 'Your contribution: £32.60 (includes tax relief of £6.52)\n';
    message += 'Employer\'s contribution: £32.60\n';
    message += 'Total contributions: £65.20\n\n';
    message += 'April 2018 - March 2019:\n';
    message += 'Your contribution: £97.81\n';
    message += '(includes tax relief of £19.56)\n';
    message += 'Employer\'s contribution: £65.21\n';
    message += 'Total contributions: £163.02\n\n';
    message += 'April 2019 onwards:\n';
    message += 'Your contribution: £163.02\n';
    message += '(includes tax relief of £32.60)\n';
    message += 'Employer\'s contribution: £97.81\n';
    message += 'Total contributions: £260.83';

    return encodeURIComponent(message);
  }

  return Email;
});
