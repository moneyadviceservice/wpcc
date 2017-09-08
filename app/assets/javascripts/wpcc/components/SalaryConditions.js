define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var SalaryConditions,
  defaultConfig = {};

  SalaryConditions = function($el, config) {
    SalaryConditions.baseConstructor.call(this, $el, config, defaultConfig);

    // Step 1 - Details
    this.$salaryField = this.$el.find('[data-wpcc-salary-input]');
    this.$salaryFrequency = this.$el.find('[data-wpcc-frequency-select]');
    this.$callout_lt5876 = this.$el.find('[data-wpcc-callout-lt5876]');
    this.$callout_gt5876_lt10000 = this.$el.find('[data-wpcc-callout-gt5876_lt10000]');
    this.$radioDisabled = this.$el.find('[data-wpcc-callout-radio-disabled]');
    this.$employerPartRadio = this.$el.find('[data-wpcc-employer-part-radio]');
    this.$employerFullRadio = this.$el.find('[data-wpcc-employer-full-radio]');
    this.contribution = 'full';

    // Step 2 - Contributions
    this.$employeeTip = this.$el.find('[data-wpcc-employee-tip]');
    this.$employeeTip_lt5876 = this.$el.find('[data-wpcc-employee-tip-lt5876]');
    this.$employerTip = this.$el.find('[data-wpcc-employer-tip]');
    this.$employeeContributions = this.$el.find('[data-wpcc-employee-contributions]');
    this.$employerContributions = this.$el.find('[data-wpcc-employer-contributions]');
  };

  DoughBaseComponent.extend(SalaryConditions);

  SalaryConditions.componentName = 'SalaryConditions';

  SalaryConditions.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setUpEvents();
    this._step2Conditions();
  };

  // Set up events to detect salary input changes
  SalaryConditions.prototype._setUpEvents = function() {
    var $this = this,
        typingTimer;

    this.$salaryField.on('keyup change', function(){
      clearTimeout(typingTimer);
      typingTimer = setTimeout(function() {
        $this._calculateAnnual()
      }, 500);
    })

    this.$salaryField.keydown(function() {
      clearTimeout(typingTimer);
    })

    this.$salaryFrequency.change(function() {
      $this._calculateAnnual();
    });

    this._checkContributionState();
  }

  // Store value of contribution selector (full/part)
  SalaryConditions.prototype._checkContributionState = function() {
    // update contribution state on page load
    if (this.$el.find('input[name="your_details_form[contribution_preference]"]:checked').val() == 'part') {
      this.contribution = 'part';
    }

    // update contribution state when selectors changed
    this.$el.find('input[name="your_details_form[contribution_preference]"]').on('change', function(e) {
      if (e.target.value == 'full') {
        this.contribution = 'full';
      } else {
        this.contribution = 'part';
      }
    });
  }

  // Function to calculate the annual salary based on different frequencies
  SalaryConditions.prototype._calculateAnnual = function() {
    var frequency    = this.$salaryFrequency.val(),
        salary       = this.$salaryField.val(),
        annualSalary = 0,
        $this        = this;

    // Calculate annual salary based on frequency
    if (frequency == 'fourweeks') {
      annualSalary = salary * 13;
    } else if (frequency == 'week') {
      annualSalary = salary * 52;
    } else if (frequency == 'month') {
      annualSalary = salary * 12;
    } else if (frequency == 'year') {
      annualSalary = salary;
    };

    // Pass the value of annual salary to display message function
    $this._displayMessage(annualSalary);
  };

  // Result of annual salary function passed to this function
  // This function displays the message and saves state to local storage
  // Local storage value used in step 2
  SalaryConditions.prototype._displayMessage = function(annualSalary) {
    var $this          = this,

        // Annual salary is less than £5876 and not empty
        lt5876         = annualSalary <= 5875 &&
                         annualSalary != '',

        // Annual salary is between £5876 and £10000 and not empty
        gt5876_lt10000 = annualSalary >= 5876 &&
                         annualSalary <= 10000 &&
                         annualSalary != '';

    if (!lt5876 && !gt5876_lt10000) {
      $this._defaultRange($this);
    } else if (lt5876) {
      $this._lessThan5876($this);
    } else if (gt5876_lt10000) {
      $this._between5876and10000($this);
    };

  };

  // Function for salary outside any conditions
  SalaryConditions.prototype._defaultRange = function($this) {
    // Hide any callouts which are displayed
    $this.$callout_lt5876.addClass('details__callout--inactive');
    $this.$callout_lt5876.removeClass('details__callout--active');
    $this.$callout_gt5876_lt10000.removeClass('details__callout--active');
    $this.$callout_gt5876_lt10000.addClass('details__callout--inactive');
    $this.$radioDisabled.removeClass('details__callout--active');
    $this.$radioDisabled.addClass('details__callout--inactive');

    // Enable radio button if disabled
    // And recheck inital option if full not already selected
    $this.$employerPartRadio.attr('disabled', false);

    if (this.contribution !== 'full') {
      $this.$employerPartRadio.prop('checked', true);
    }

    // Remove local storage if already saved
    localStorage.removeItem('lt5876');
  }

  // Function for salary less than £5876
  SalaryConditions.prototype._lessThan5876 = function($this) {
    // Show relevant callouts
    $this.$callout_lt5876.removeClass('details__callout--inactive');
    $this.$callout_lt5876.addClass('details__callout--active');
    $this.$radioDisabled.removeClass('details__callout--inactive');
    $this.$radioDisabled.addClass('details__callout--active');

    // Hide other callouts if visible
    $this.$callout_gt5876_lt10000.addClass('details__callout--inactive');
    $this.$callout_gt5876_lt10000.removeClass('details__callout--active');

    // Disable Employer contributions checkbox
    $this.$employerPartRadio.attr('disabled', true);
    $this.$employerFullRadio.prop('checked', true);

    // Save state to local storage
    localStorage.setItem('lt5876', true);
  };

  // Function for salary between £5876 and £10000
  SalaryConditions.prototype._between5876and10000 = function($this) {
    // Display relevant callout
    $this.$callout_gt5876_lt10000.removeClass('details__callout--inactive');
    $this.$callout_gt5876_lt10000.addClass('details__callout--active');

    // Hide previous callout if active
    $this.$callout_lt5876.addClass('details__callout--inactive');
    $this.$callout_lt5876.removeClass('details__callout--active');
    $this.$radioDisabled.removeClass('details__callout--active');
    $this.$radioDisabled.addClass('details__callout--inactive');

    // Enable radio button if disabled
    // And recheck inital option if full not already selected
    $this.$employerPartRadio.attr('disabled', false);

    if (this.contribution !== 'full') {
      $this.$employerPartRadio.prop('checked', true);
    }

    // Remove local storage if already saved
    localStorage.removeItem('lt5876');
  }

  // Step 2 - Alters values of the contribution inputs
  // Modifies the employee contributions tip
  SalaryConditions.prototype._step2Conditions = function() {
    var salaryCondition = localStorage.getItem('lt5876'),
        $this           = this;

    if (salaryCondition) {
      this._updateEmployeeTip();
      this.$employeeTip.addClass('is-hidden');
      this.$employeeTip_lt5876.removeClass('is-hidden');
    } else {
      this.$employeeTip.removeClass('is-hidden');
      this.$employeeTip_lt5876.addClass('is-hidden');
    }

  };

  // Called from _step2Conditions
  // Updates the values of the contributions inputs
  // And removes the employer tip
  SalaryConditions.prototype._updateEmployeeTip = function() {
    this.$employeeContributions.val(1);
    this.$employerContributions.val(0);
    this.$employerTip.text('');
  }

  return SalaryConditions;
});
