define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var UpdateResults,
    defaultConfig = {
      i18nStrings: {
        parentheses: 'includes tax relief of £'
      }
    };

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
      _this._displayValues();
    });
  }

  // Get the intial values from the DOM
  // and store in values object
  UpdateResults.prototype._getValues = function() {
    var _this = this;
    var unitConverter = this._unitConverter();

    this.resultsTables.each(function() {
      _this.values.employeeContributions.push($(this).find('[data-dough-employee-contribution]').attr('data-value') * unitConverter);
      _this.values.employerContributions.push($(this).find('[data-dough-employer-contribution]').attr('data-value') * unitConverter);
      _this.values.taxRelief.push($(this).find('[data-dough-tax-relief]').attr('data-value') * unitConverter);
    });
  }

  // Display recalculated values in tables
  UpdateResults.prototype._displayValues = function() {
    var unitConverter = this._unitConverter();

    // calculate & display new values
    for (var i = 0, max = this.resultsTables.length; i < max; i++) {
      var employeeContributions = (this.values.employeeContributions[i] / unitConverter).toFixed(2);
      var employerContributions = (this.values.employerContributions[i] / unitConverter).toFixed(2);
      var taxRelief = (this.values.taxRelief[i] / unitConverter).toFixed(2);
      var total = parseFloat(employeeContributions) + parseFloat(employerContributions);
      var employeeContributions_html = '£' + employeeContributions.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      var employerContributions_html = '£' + employerContributions.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      var taxRelief_html = '(' + this.config.i18nStrings.parentheses + taxRelief + ')';
      var total_html = '£' + total.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");

      $(this.resultsTables[i]).find('[data-dough-employee-contribution]').html(employeeContributions_html);
      $(this.resultsTables[i]).find('[data-dough-employer-contribution]').html(employerContributions_html);
      $(this.resultsTables[i]).find('[data-dough-tax-relief]').html(taxRelief_html);
      $(this.resultsTables[i]).find('[data-dough-total]').html(total_html);
    };
  }

  // Get unitConverter from frequency dropdown
  UpdateResults.prototype._unitConverter = function() {
    return this.frequencySelector.find('option:selected').attr('data-unit-converter');
  };

  return UpdateResults;
});
