define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var UpdateResults,
    defaultConfig = {};

  UpdateResults = function($el, config) {
    UpdateResults.baseConstructor.call(this, $el, config, defaultConfig);

    this.frequencySelector = this.$el.find('[data-dough-selector]');
    this.resultsTables = this.$el.find('[data-dough-results-table]')
    this.values = {
      employeeContributions: [],
      employerContributions: [],
      taxRelief: []
    };
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(UpdateResults);

  UpdateResults.componentName = 'UpdateResults';

  UpdateResults.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setupEvents();
    this._getValues();
  };

  // Set event for change of frequency selector
  UpdateResults.prototype._setupEvents = function() {
    var _this = this;

    this.frequencySelector.change(function() {
      _this._displayValues(this.value);
    });
  }

  // Get the intial values from the DOM
  // and store in values object
  UpdateResults.prototype._getValues = function() {
    var _this = this;
    var frequency = this.frequencySelector.val();
    var modifier = this._getModifier(frequency);

    this.resultsTables.each(function() {
      _this.values.employeeContributions.push($(this).find('[data-dough-employee-contribution]').attr('data-value') * modifier);
      _this.values.employerContributions.push($(this).find('[data-dough-employer-contribution]').attr('data-value') * modifier);
      _this.values.taxRelief.push($(this).find('[data-dough-tax-relief]').attr('data-value') * modifier);
    });
  }

  // Display recalculated values in tables
  UpdateResults.prototype._displayValues = function(frequency) {
    var _this = this;
    var modifier = this._getModifier(frequency);

    // calculate & display new values
    for (var i = 0, max = this.resultsTables.length; i < max; i++) {
      $(this.resultsTables[i]).find('[data-dough-employee-contribution]').html(_this._formatNumber(_this.values.employeeContributions[i], modifier));
      $(this.resultsTables[i]).find('[data-dough-employer-contribution]').html(_this._formatNumber(_this.values.employerContributions[i], modifier));
      $(this.resultsTables[i]).find('[data-dough-tax-relief]').html('(includes tax relief of ' + _this._formatNumber(_this.values.taxRelief[i], modifier) + ')');
      $(this.resultsTables[i]).find('[data-dough-total]').html(_this._formatNumber(_this.values.employeeContributions[i] + _this.values.employerContributions[i], modifier));
    };
  }

  // Get modifier from frequency
  // Used to convert amounts from/to annual
  UpdateResults.prototype._getModifier = function(frequency) {
    var modifiers = {
      'year': function() {
        return 1;
      },
      'month': function() {
        return 12;
      },
      'fourweeks': function() {
        return 13;
      },
      'week': function() {
        return 52;
      }
    };

    return modifiers[frequency]();
  };

  // formats number to currency
  UpdateResults.prototype._formatNumber = function(num, modifier) {
    // format decimal places
    num = (num / modifier).toFixed(2);

    // format commas
    num = num.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    return '£' + num;
  }

  return UpdateResults;
});
