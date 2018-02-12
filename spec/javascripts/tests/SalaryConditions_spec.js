describe('Salary Conditions', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    requirejs(
      ['jquery', 'SalaryConditions'],
      function($, SalaryConditions) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/SalaryConditions.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="SalaryConditions"]');
        _this.salaryConditions = SalaryConditions;
        _this.obj = new _this.salaryConditions(_this.component, _this.component.data('dough-salary-conditions-config'));
        _this.delay = 550;
        done();
      }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('When salary field is changed', function() {

    var clock;

    beforeEach(function() {
      this.salaryField = this.component.find('[data-wpcc-salary-input]');
      this.salaryFrequency = this.component.find('[data-wpcc-frequency-select]');
      this.callout_lt6032 = this.component.find('[data-wpcc-callout-lt6032]');
      this.callout_gt6032_lt10000 = this.component.find('[data-wpcc-callout-gt6032_lt10000]');
      this.callout_near_pension_threshold = this.component.find('[data-wpcc-callout-near_pension_threshold]');
      this.callout_near_auto_enrollment_threshold = this.component.find('[data-wpcc-callout-near_auto_enrollment_threshold]');
      this.callout_lt6032_min_contribution = this.component.find('[data-wpcc-callout-lt6032-min-contribution]');
      this.employerPartRadio = this.component.find('[data-wpcc-employer-part-radio]');
      this.employerFullRadio = this.component.find('[data-wpcc-employer-full-radio]');

      clock = sinon.useFakeTimers();

      // set initial values for salary field and checked radio control
      this.salaryField.val(null);
      this.component.find('input[name="your_details_form[contribution_preference]"]')[1].checked = true;  // full salary selected

      this.obj.init();
    });

    afterEach(function() {
      clock.restore();
    });

    it('Does not display callouts when salary field is empty', function() {
      this.salaryField.val(null);
      this.salaryFrequency.val('year');

      expect(
        this.callout_lt6032.hasClass('details__callout--inactive')
      ).to.be.true;

      expect(
        this.callout_gt6032_lt10000.hasClass('details__callout--inactive')
      ).to.be.true;

      expect(
        this.callout_lt6032_min_contribution.hasClass('details__callout--inactive')
      ).to.be.true;
    });

    describe('When salary is less than £6032', function() {
      it('Shows the correct callout and checks the correct radio control', function(done) {
        this.salaryFrequency.val('year');
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_lt6032.hasClass('details__callout--active')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('full');
        done();
      });

      it('Disables the employer part contribution radio and checks the correct radio control', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.employerPartRadio.prop('disabled')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('full');
        done();
      });

      it('Displays disabled radio callout and checks the correct radio control', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_lt6032_min_contribution.hasClass('details__callout--active')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('full');
        done();
      });

      it('Selects the employer full contribution radio option', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('full');
        done();
      });
    });

    describe('When yearly salary is between £6032 and £10000', function() {
      it('Shows the correct callout and checks the correct radio control', function(done) {
        this.salaryFrequency.val('year')
        this.salaryField.val('7000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_gt6032_lt10000.hasClass('details__callout--active')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('minimum');
        done();
      });
    });

    describe('When monthly salary is between £503 and £833', function() {
      it('Shows the correct callout and checks the correct radio control', function(done) {
        this.salaryFrequency.val('month')
        this.salaryField.val('503');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_gt6032_lt10000.hasClass('details__callout--active')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('minimum');
        done();
      });
    });

    describe('When 4-weekly salary is between £464 and £768', function() {
      it('Shows the correct callout and checks the correct radio control', function(done) {
        this.salaryFrequency.val('fourweeks')
        this.salaryField.val('500');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_gt6032_lt10000.hasClass('details__callout--active')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('minimum');
        done();
      });
    });

    describe('When weekly salary is between £116 and £192', function() {
      it('Shows the correct callout and checks the correct radio control', function(done) {
        this.salaryFrequency.val('week')
        this.salaryField.val('116');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_gt6032_lt10000.hasClass('details__callout--active')
        ).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('minimum');
        done();
      });
    });

    describe('When salary is equal to or greater than £10000', function() {
      it('Does not display any callouts and checks the correct radio control', function(done) {
        this.salaryField.val('22000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.callout_gt6032_lt10000.hasClass('details__callout--inactive')).to.be.true;
        expect(
          this.component.find('input[name="your_details_form[contribution_preference]"]:checked').val()
        ).to.equal('minimum');
        done();
      });
    });

    describe('When yearly salary is within ±£10 of £6032', function() {
      it('Shows the correct callout', function(done) {
        this.salaryFrequency.val('year');
        this.salaryField.val('6022');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.callout_near_pension_threshold.hasClass('details__callout--active')).to.be.true;
        done();
      });
    });

    describe('When yearly salary is NOT within ±£10 of £6032', function() {
      it('Shows the correct callout', function(done) {
        this.salaryFrequency.val('year');
        this.salaryField.val('5865');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.callout_near_pension_threshold.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_near_pension_threshold.hasClass('details__callout--inactive')).to.be.true;
        done();
      });
    });

    describe('When yearly salary is within ±£10 of £10,000', function() {
      it('Shows the correct callout', function(done) {
        this.salaryFrequency.val('year');
        this.salaryField.val('9990');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.callout_near_auto_enrollment_threshold.hasClass('details__callout--active')).to.be.true;
        done();
      });
    });

    describe('When yearly salary is NOT within ±£10 of 10,000', function() {
      it('Shows the correct callout', function(done) {
        this.salaryFrequency.val('year');
        this.salaryField.val('9989');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.callout_near_auto_enrollment_threshold.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_near_auto_enrollment_threshold.hasClass('details__callout--inactive')).to.be.true;
        done();
      });
    });
  });

  describe('When frequency field is changed', function() {
    var clock;

    beforeEach(function() {

      this.triggerChange = function(element, value) {
        var e = $.Event('change');
        $(element).val(value);
        element.trigger(e);
      };

      this.salaryField = this.component.find('[data-wpcc-salary-input]');
      this.salaryFrequency = this.component.find('[data-wpcc-frequency-select]');
      this.callout_lt6032 = this.component.find('[data-wpcc-callout-lt6032]');
      this.callout_gt6032_lt10000 = this.component.find('[data-wpcc-callout-gt6032_lt10000]');
      this.callout_lt6032_min_contribution = this.component.find('[data-wpcc-callout-lt6032-min-contribution]');
      clock = sinon.useFakeTimers();
      this.obj.init();
    });

    afterEach(function() {
      clock.restore();
    });

    it('Displays correct callout based on monthly frequency', function(done) {
      this.salaryField.val('300');
      this.salaryFrequency.val('month');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(
        this.callout_lt6032.hasClass('details__callout--active')
      ).to.be.true;
      done();
    });

    it('Displays correct callout based on fourweeks frequency', function(done) {
      this.salaryField.val('300');
      this.salaryFrequency.val('fourweeks');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(
        this.callout_lt6032.hasClass('details__callout--active')
      ).to.be.true;
      done();
    });

    it('Displays correct callout based on weekly frequency', function(done) {
      this.salaryField.val('30');
      this.salaryFrequency.val('week');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(
        this.callout_lt6032.hasClass('details__callout--active')
      ).to.be.true;
      done();
    });

    it('Hides the callout if frequency is changed equalling a salary over £6032', function() {
      this.salaryField.val('5000');
      this.salaryFrequency.val('year');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(
        this.callout_lt6032.hasClass('details__callout--active')
      ).to.be.true;

      this.triggerChange(this.salaryFrequency, 'month');
      expect(
        this.callout_lt6032.hasClass('details__callout--inactive')
      ).to.be.true;
    });

  });

  describe('When user proceeds to step 2 with salary of £6032 or above', function() {
    var clock;

    beforeEach(function() {
      this.salaryField = this.component.find('[data-wpcc-salary-input]');
      this.employeeContributions = this.component.find('[data-wpcc-employee-contributions]');
      this.employerContributions = this.component.find('[data-wpcc-employer-contributions]');
      this.employeeTip = this.component.find('[data-wpcc-employee-tip]');
      this.employeeTip_lt6032 = this.component.find('[data-wpcc-employee-tip-lt6032]');
      this.employerTip = this.component.find('[data-wpcc-employer-tip]');
      clock = sinon.useFakeTimers();
      this.obj.init();
    });

    it('Shows the original contribution values', function(done) {
      this.salaryField.val('6035');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(this.employeeContributions.val()).to.equal('1');
      expect(this.employerContributions.val()).to.equal('1');
      done();
    });

    it('Displays the correct contribution tips', function(done) {
      this.salaryField.val('6035');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(this.employeeTip.hasClass('is-hidden')).to.be.false;
      expect(this.employeeTip_lt6032.hasClass('is-hidden')).to.be.true;
      expect(this.employerTip.text()).to.not.equal(null);
      done();
    });
  });
});
