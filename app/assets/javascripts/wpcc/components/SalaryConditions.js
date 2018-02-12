define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var SalaryConditions;
  var defaultConfig = {};

  SalaryConditions = function($el, config) {
    SalaryConditions.baseConstructor.call(this, $el, config, defaultConfig);

    // Step 1 - Details
    this.$salaryField = this.$el.find('[data-wpcc-salary-input]');
    this.$salaryFrequency = this.$el.find('[data-wpcc-frequency-select]');
    this.$callout_lt6032 = this.$el.find('[data-wpcc-callout-lt6032]');
    this.$callout_gt6032_lt10000 = this.$el.find('[data-wpcc-callout-gt6032_lt10000]');
    this.$callout_near_pension_threshold = this.$el.find('[data-wpcc-callout-near_pension_threshold]');
    this.$callout_near_auto_enrollment_threshold = this.$el.find('[data-wpcc-callout-near_auto_enrollment_threshold]');
    this.$callout_lt6032_min_contribution = this.$el.find('[data-wpcc-callout-lt6032-min-contribution]');
    this.$employerPartRadio = this.$el.find('[data-wpcc-employer-part-radio]');
    this.$employerFullRadio = this.$el.find('[data-wpcc-employer-full-radio]');
    this.contribution = 'part';

    // Step 2 - Contributions
    this.optInTriggers = config;
    this.$employeeTip = this.$el.find('[data-wpcc-employee-tip]');
    this.$employeeTip_lt6032 = this.$el.find('[data-wpcc-employee-tip-lt6032]');
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
    var thresholds = this.optInTriggers[frequency];
    if (salary < thresholds.lower) return true;
  };

  SalaryConditions.prototype._manualOptInRequired = function(salary, frequency) {
    var thresholds = this.optInTriggers[frequency];
    if (this._salaryInRange(salary, thresholds.lower, thresholds.upper)) return true;
  };

  SalaryConditions.prototype._nearPensionThreshold = function(salary, frequency) {
    var thresholds = this.optInTriggers[frequency];
    var bottomOfRange = thresholds.lower - 10;
    var topOfRange = thresholds.lower + 10;
    if (this._salaryInRange(salary, bottomOfRange, topOfRange)) return true;
  };

  SalaryConditions.prototype._nearAutoEnrollThreshold = function(salary, frequency) {
    var thresholds = this.optInTriggers[frequency];
    var bottomOfRange = thresholds.upper - 10;
    var topOfRange = thresholds.upper + 10;
    if (this._salaryInRange(salary, bottomOfRange, topOfRange)) return true;
  };

  SalaryConditions.prototype._salaryInRange = function(salary, bottomOfRange, topOfRange) {
    if (salary >= bottomOfRange && salary <= topOfRange) return true;
  }
  // This function determines which if any salary message is to be displayed
  SalaryConditions.prototype._salaryMessage = function() {
    var frequency               = this.$salaryFrequency.val(),
        salary                  = this.$salaryField.val(),
        $this                   = this,
        belowManualOptIn        = $this._belowManualOptIn(salary, frequency),
        manualOptInRequired     = $this._manualOptInRequired(salary, frequency),
        nearPensionThreshold    = $this._nearPensionThreshold(salary, frequency),
        nearAutoEnrollThreshold = $this._nearAutoEnrollThreshold(salary, frequency);

    $this._displayMessage(belowManualOptIn, manualOptInRequired, nearPensionThreshold, nearAutoEnrollThreshold);
  };

  // This function displays the message and saves state to local storage
  // Local storage value used in step 2
  SalaryConditions.prototype._displayMessage = function(belowManualOptIn, manualOptInRequired, nearPensionThreshold, nearAutoEnrollThreshold) {
    var $this          = this,

        // salary is below the manual opt limit
        lt6032         = belowManualOptIn,

        // salary is between the manual opt-in limits for the salary frequency
        gt6032_lt10000 = manualOptInRequired,

        // salary is near the pension threshold of 6032
        nearLowerThreshold = nearPensionThreshold,

        // salary is near the pension threshold of 10000
        nearUpperThreshold = nearAutoEnrollThreshold;

    if (!lt6032 && !gt6032_lt10000){
      $this._defaultRange($this);
    } else if (lt6032) {
      $this._lessThan6032($this);
    } else if (gt6032_lt10000) {
      $this._between6032and10000($this);
    };

    if (nearLowerThreshold){
      $this._nearPensionThresholdMessage($this);
    } else if (nearUpperThreshold){
      $this._nearAutoEnrollThresholdMessage($this);
    } else {
      $this._clearNearThresholdMessages($this);
    };
  };

  SalaryConditions.prototype._clearNearThresholdMessages = function($this) {
    // Hide any callouts which are displayed
    $this.$callout_near_pension_threshold.removeClass('details__callout--active');
    $this.$callout_near_pension_threshold.addClass('details__callout--inactive');
    $this.$callout_near_auto_enrollment_threshold.removeClass('details__callout--active');
    $this.$callout_near_auto_enrollment_threshold.addClass('details__callout--inactive');
  }

  // Function for salary outside any conditions
  SalaryConditions.prototype._defaultRange = function($this) {
    // Hide any callouts which are displayed
    $this.$callout_lt6032.addClass('details__callout--inactive');
    $this.$callout_lt6032.removeClass('details__callout--active');
    $this.$callout_gt6032_lt10000.removeClass('details__callout--active');
    $this.$callout_gt6032_lt10000.addClass('details__callout--inactive');
    $this.$callout_lt6032_min_contribution.removeClass('details__callout--active');
    $this.$callout_lt6032_min_contribution.addClass('details__callout--inactive');
    $this.$callout_near_pension_threshold.removeClass('details__callout--active');
    $this.$callout_near_pension_threshold.addClass('details__callout--inactive');
    $this.$callout_near_auto_enrollment_threshold.removeClass('details__callout--active');
    $this.$callout_near_auto_enrollment_threshold.addClass('details__callout--inactive');

    // Enable radio button if disabled
    // And recheck inital option if full not already selected
    $this.$employerPartRadio.attr('disabled', false);

    if (this.contribution !== 'full') {
      $this.$employerPartRadio.prop('checked', true);
    }
  }

  // Function for salary less than £6032
  SalaryConditions.prototype._lessThan6032 = function($this) {
    // Show relevant callouts
    $this.$callout_lt6032.removeClass('details__callout--inactive');
    $this.$callout_lt6032.addClass('details__callout--active');
    $this.$callout_lt6032_min_contribution.removeClass('details__callout--inactive');
    $this.$callout_lt6032_min_contribution.addClass('details__callout--active');

    // Hide other callouts if visible
    $this.$callout_gt6032_lt10000.addClass('details__callout--inactive');
    $this.$callout_gt6032_lt10000.removeClass('details__callout--active');

    // Disable Employer contributions checkbox
    $this.$employerPartRadio.attr('disabled', true);
    $this.$employerFullRadio.prop('checked', true);
  };

  // Function for salary between £6032 and £10000
  SalaryConditions.prototype._between6032and10000 = function($this) {
    // Display relevant callout
    $this.$callout_gt6032_lt10000.removeClass('details__callout--inactive');
    $this.$callout_gt6032_lt10000.addClass('details__callout--active');

    // Hide previous callout if active
    $this.$callout_lt6032.addClass('details__callout--inactive');
    $this.$callout_lt6032.removeClass('details__callout--active');
    $this.$callout_lt6032_min_contribution.removeClass('details__callout--active');
    $this.$callout_lt6032_min_contribution.addClass('details__callout--inactive');

    // Enable radio button if disabled
    // And recheck inital option if full not already selected
    $this.$employerPartRadio.attr('disabled', false);

    if (this.contribution !== 'full') {
      $this.$employerPartRadio.prop('checked', true);
    }
  }

  // Function for salary close to £6032 callout_near_pension_threshold
  SalaryConditions.prototype._nearPensionThresholdMessage = function($this) {
    // Show relevant callouts
    $this.$callout_near_pension_threshold.removeClass('details__callout--inactive');
    $this.$callout_near_pension_threshold.addClass('details__callout--active');
  };

  // Function for salary close to £1000 callout-near_auto_enrollment_threshold
  SalaryConditions.prototype._nearAutoEnrollThresholdMessage = function($this) {
    // Show relevant callouts
    $this.$callout_near_auto_enrollment_threshold.removeClass('details__callout--inactive');
    $this.$callout_near_auto_enrollment_threshold.addClass('details__callout--active');
  };
  return SalaryConditions;
});
