define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var StepTransition,
    defaultConfig = {
      activeFormClass: 'form--active',
      inactiveFormClass: 'form--inactive',
    };

  StepTransition = function($el, config) {
    StepTransition.baseConstructor.call(this, $el, config, defaultConfig);

    // SampleJson
    this.$jsonResponse = this.config.json_response;

    // Sections
    this.$detailsSection = this.$el.find('[data-dough-transition-details]');
    this.$contributionsSection = this.$el.find('[data-dough-transition-contributions]');
    this.$resultsSection = this.$el.find('[data-dough-transition-results]');

    // Forms
    this.$detailsForm = this.$el.find('[data-dough-details-form]');
    this.$detailsFormPath = this.$detailsForm.attr('action');
    this.$contributionForm = this.$el.find('[data-dough-contribution-form]');

    // Headings
    this.$detailsHeading = this.$el.find('.details__heading');

    // Buttons
    this.$detailsSubmit = this.$el.find('[data-dough-submit]');
    this.$detailsEdit = this.$el.find('.js-edit-details');

    // Fields
    this.$ageField = this.$el.find('[data-dough-age-field]');
    this.$genderField = this.$el.find('[data-dough-gender-select]');
    this.$salaryField = this.$el.find('[data-dough-salary-input]');
    this.$salaryFrequency = this.$el.find('[data-dough-frequency-select]');

    // Options
    this.$employerPartOption = this.$el.find('[data-dough-employer-part-radio]');
    this.$employerFullOption = this.$el.find('[data-dough-employer-part-radio]');

  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(StepTransition);

  StepTransition.componentName = 'StepTransition';

  StepTransition.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setupEvents();
  };

  StepTransition.prototype._setupEvents = function() {
    var $this = this;

    $this.$detailsForm.submit(function(event){
      event.preventDefault();
      $this._prepareAJAXpost($this);
    });
  };

  StepTransition.prototype._prepareAJAXpost = function($this) {

    var postData = $this.$detailsForm.serialize();

    $.ajax({
      type: "post",
      url: $this.$detailsFormPath,
      data: postData,
      contentType: "application/x-www-form-urlencoded",
      success: function(responseData, textStatus, jqXHR) {
        $this._receiveAJAXresponse(responseData);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log('Response Error: ' + errorThrown);
        $this.$detailsForm.unbind('submit').submit();
      }
    })
  };

  StepTransition.prototype._receiveAJAXresponse = function(responseData) {
    
    var $this = this,
        $eligibleSalary = responseData.eligible_salary,
        $salaryFrequency = responseData.frequency,
        $gender = responseData.gender,
        $age = responseData.age,
        $contributionPreference = responseData.contribution_preference;

    // Hide the your details section
    $this._toggleDetailsSection($this);

    // Display Your Contributions section
    $this._toggleContributionSection($this);

    // Add summary to details header
    $this.$detailsHeading.append(
      ' <span class="section__heading-summary">('
      + $age + ' years, '
      + $gender + ', ' + '£'
      + $eligibleSalary + ' ' + $salaryFrequency + ', ' 
      + $contributionPreference + ' Contribution)</span> '
      + '<button class="section__heading-edit js-edit-details">Edit</button>' 
      );

    $this._editSectionEvents($this);

    // For development purposes
    // console.log(
    //   'Age: ' + $age + '\n' + 
    //   'Gender: ' + $gender + '\n' + 
    //   'Eligable Salary: ' + $eligibleSalary + '\n' + 
    //   'Salary frequency: ' + $salaryFrequency + '\n' + 
    //   'Contribution: ' + $contribution
    // );
  };

  // Toggle form views
  StepTransition.prototype._toggleDetailsSection = function($this) {

    if ($this.$detailsForm.hasClass(this.config.activeFormClass)) {
      $this.$detailsForm.addClass(this.config.inactiveFormClass);
      $this.$detailsForm.removeClass(this.config.activeFormClass);
    } else {
      $this.$detailsForm.addClass(this.config.activeFormClass);
      $this.$detailsForm.removeClass(this.config.inactiveFormClass);
    }
    
  };

  StepTransition.prototype._toggleContributionSection = function($this) {

    if ($this.$contributionForm.hasClass(this.config.activeFormClass)) {
      $this.$contributionForm.addClass(this.config.inactiveFormClass);
      $this.$contributionForm.removeClass(this.config.activeFormClass);
    } else {
      $this.$contributionForm.addClass(this.config.activeFormClass);
      $this.$contributionForm.removeClass(this.config.inactiveFormClass);
    }

  };

  // Edit button behaviour
  StepTransition.prototype._editSectionEvents = function($this) {
    var $this = this,
        detailsEdit = $('.js-edit-details');

    detailsEdit.click(function(){
      $this._toggleDetailsSection($this);
      $this._toggleContributionSection($this);
      $this._hideDetailsSummary();
    });
  };

  // Remove the heading summary
  StepTransition.prototype._hideDetailsSummary = function() {
    $('.section__heading-summary').remove();
    $('.js-edit-details').remove();
  };

  return StepTransition;
});
