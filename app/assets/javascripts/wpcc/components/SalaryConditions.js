define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var SalaryConditions;
  var defaultConfig = {};
  var optInTriggers = {
      year: {
        lower: 5876.00,
        upper: 10000.00
      },
      month: {
        lower: 490.00,
        upper: 833.00
      },
      fourweeks: {
        lower: 452.00,
        upper: 768.00
      },
      week: {
        lower: 113.00,
        upper: 192.00
      }
    };

  SalaryConditions = function($el, config) {
    SalaryConditions.baseConstructor.call(this, $el, config, defaultConfig);

    // Step 1 - Details
    this.$salaryField = this.$el.find('[data-wpcc-salary-input]');
    this.$salaryFrequency = this.$el.find('[data-wpcc-frequency-select]');
    this.$callout_lt5876 = this.$el.find('[data-wpcc-callout-lt5876]');
    this.$callout_gt5876_lt10000 = this.$el.find('[data-wpcc-callout-gt5876_lt10000]');
    this.$callout_near_pension_threshold = this.$el.find('[data-wpcc-callout-near_pension_threshold]');
    this.$callout_lt5876_min_contribution = this.$el.find('[data-wpcc-callout-lt5876-min-contribution]');
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
  };

  // Set up events to detect salary input changes
  SalaryConditions.prototype._setUpEvents = function() {
    var $this = this,
        typingTimer;

    this.$salaryField.on('keyup change', function(){
      clearTimeout(typingTimer);
      typingTimer = setTimeout(function() {
        $this._salaryMessage()
      }, 500);
    })

    this.$salaryField.keydown(function() {
      clearTimeout(typingTimer);
    })

    this.$salaryFrequency.change(function() {
      $this._salaryMessage();
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

  SalaryConditions.prototype._belowManualOptIn = function(salary, frequency) {
    var thresholds = optInTriggers[frequency];
    if (salary < thresholds.lower) {
      return true;
    }

  };

  SalaryConditions.prototype._manualOptInRequired = function(salary, frequency) {
    var thresholds = optInTriggers[frequency];
    if (salary >= thresholds.lower && salary <= thresholds.upper) {
      return true;
    }
  };

  SalaryConditions.prototype._nearPensionThreshold = function(salary, frequency) {
    var thresholds = optInTriggers[frequency];
    var bottomOfRange = thresholds.lower - 10;
    var topOfRange = thresholds.lower + 10;
    if (salary >= bottomOfRange && salary <= topOfRange) {
      return true;
    }
  };

  // This function determines which if any salary message is to be displayed
  SalaryConditions.prototype._salaryMessage = function() {
    var frequency            = this.$salaryFrequency.val(),
        salary               = this.$salaryField.val(),
        $this                = this,
        belowManualOptIn     = $this._belowManualOptIn(salary, frequency),
        manualOptInRequired  = $this._manualOptInRequired(salary, frequency),
        nearPensionThreshold = $this._nearPensionThreshold(salary, frequency);

    $this._displayMessage(belowManualOptIn, manualOptInRequired, nearPensionThreshold);
  };

  // This function displays the message and saves state to local storage
  // Local storage value used in step 2
  SalaryConditions.prototype._displayMessage = function(belowManualOptIn, manualOptInRequired, nearPensionThreshold) {
    var $this          = this,

        // salary is below the manual opt limit
        lt5876         = belowManualOptIn,

        // salary is between the manual opt-in limits for the salary frequency
        gt5876_lt10000 = manualOptInRequired,

        // salary is near the pension threshold of 5876
        nearLowerThreshold = nearPensionThreshold;

    if (!lt5876 && !gt5876_lt10000){
      $this._defaultRange($this);
    } else if (lt5876) {
      $this._lessThan5876($this);
    } else if (gt5876_lt10000) {
      $this._between5876and10000($this);
    };

    if (nearLowerThreshold){
      $this._nearPensionThresholdMessage($this);
    };
  };

  // Function for salary outside any conditions
  SalaryConditions.prototype._defaultRange = function($this) {
    // Hide any callouts which are displayed
    $this.$callout_lt5876.addClass('details__callout--inactive');
    $this.$callout_lt5876.removeClass('details__callout--active');
    $this.$callout_gt5876_lt10000.removeClass('details__callout--active');
    $this.$callout_gt5876_lt10000.addClass('details__callout--inactive');
    $this.$callout_lt5876_min_contribution.removeClass('details__callout--active');
    $this.$callout_lt5876_min_contribution.addClass('details__callout--inactive');
    $this.$callout_near_pension_threshold.removeClass('details__callout--active');
    $this.$callout_near_pension_threshold.addClass('details__callout--inactive');

    // Enable radio button if disabled
    // And recheck inital option if full not already selected
    $this.$employerPartRadio.attr('disabled', false);

    if (this.contribution !== 'full') {
      $this.$employerPartRadio.prop('checked', true);
    }
  }

  // Function for salary less than £5876
  SalaryConditions.prototype._lessThan5876 = function($this) {
    // Show relevant callouts
    $this.$callout_lt5876.removeClass('details__callout--inactive');
    $this.$callout_lt5876.addClass('details__callout--active');
    $this.$callout_lt5876_min_contribution.removeClass('details__callout--inactive');
    $this.$callout_lt5876_min_contribution.addClass('details__callout--active');

    // Hide other callouts if visible
    $this.$callout_gt5876_lt10000.addClass('details__callout--inactive');
    $this.$callout_gt5876_lt10000.removeClass('details__callout--active');

    // Disable Employer contributions checkbox
    $this.$employerPartRadio.attr('disabled', true);
    $this.$employerFullRadio.prop('checked', true);
  };

  // Function for salary between £5876 and £10000
  SalaryConditions.prototype._between5876and10000 = function($this) {
    // Display relevant callout
    $this.$callout_gt5876_lt10000.removeClass('details__callout--inactive');
    $this.$callout_gt5876_lt10000.addClass('details__callout--active');

    // Hide previous callout if active
    $this.$callout_lt5876.addClass('details__callout--inactive');
    $this.$callout_lt5876.removeClass('details__callout--active');
    $this.$callout_lt5876_min_contribution.removeClass('details__callout--active');
    $this.$callout_lt5876_min_contribution.addClass('details__callout--inactive');

    // Enable radio button if disabled
    // And recheck inital option if full not already selected
    $this.$employerPartRadio.attr('disabled', false);

    if (this.contribution !== 'full') {
      $this.$employerPartRadio.prop('checked', true);
    }
  }

  // Function for salary close to £5876 callout_near_pension_threshold
  SalaryConditions.prototype._nearPensionThresholdMessage = function($this) {
    // Show relevant callouts
    $this.$callout_near_pension_threshold.removeClass('details__callout--inactive');
    $this.$callout_near_pension_threshold.addClass('details__callout--active');
  };

  return SalaryConditions;
});
