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
        _this.obj = new _this.salaryConditions(_this.component);
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
      this.salaryField = this.component.find('[data-dough-salary-input]');
      this.salaryFrequency = this.component.find('[data-dough-frequency-select]');
      this.callout_lt5876 = this.component.find('[data-dough-callout-lt5876]');
      this.callout_gt5876_lt10000 = this.component.find('[data-dough-callout-gt5876_lt10000]');
      this.radioDisabled = this.component.find('[data-dough-callout-radio-disabled]');
      this.employerPartRadio = this.component.find('[data-dough-employer-part-radio]');
      this.employerFullRadio = this.component.find('[data-dough-employer-full-radio]');
      clock = sinon.useFakeTimers();
      this.obj.init();
    });

    afterEach(function() {
      clock.restore();
    });

    it('Does not display callouts when salary field is empty', function() {
      this.salaryField.val(null);
      this.salaryFrequency.val('year');

      expect(
        this.callout_lt5876.hasClass('details__callout--inactive')
      ).to.be.true;

      expect(
        this.callout_gt5876_lt10000.hasClass('details__callout--inactive')
      ).to.be.true;

      expect(
        this.radioDisabled.hasClass('details__callout--inactive')
      ).to.be.true;
    });

    describe('When salary is less than £5876', function() {
      it('Shows the correct callout', function(done) {
        this.salaryFrequency.val('year');
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_lt5876.hasClass('details__callout--active')
        ).to.be.true;
        done();
      });

      it('Disables the employer part contribution radio', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.employerPartRadio.prop('disabled')).to.be.true;
        done();
      })

      it('Displays disabled radio callout', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.radioDisabled.hasClass('details__callout--active')
        ).to.be.true;
        done();
      });

      it('Selects the employer full contribution radio option', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.employerFullRadio.prop('checked')).to.be.true;
        done();
      })

      it('Saves this state to local storage', function(done) {
        this.salaryField.val('3000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(localStorage.getItem('lt5876')).to.equal('true');
        done();
      })

      it('Clears state from localStorage if salary is changed to above £5867', 
        function(done) {
        this.salaryField.val('5879');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(localStorage.getItem('lt5876')).to.be.equal(null);
        done();
      })
    });

    describe('When salary is between £5876 and £10000', function() {
      it('Shows the correct callout', function(done) {
        this.salaryField.val('7000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(
          this.callout_gt5876_lt10000.hasClass('details__callout--active')
        ).to.be.true;
        done();
      });
    });

    describe('When salary is equal to or greater than £10000', function() {
      it('Does not display any callouts', function(done) {
        this.salaryField.val('22000');
        this.salaryField.trigger('keyup');
        clock.tick(this.delay);
        expect(this.callout_gt5876_lt10000.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt5876_lt10000.hasClass('details__callout--inactive')).to.be.true;
        done();
      })
    });

  });

  describe('When user proceeds to step 2 with salary below £5876', function() {
    var clock;

    beforeEach(function() {
      this.salaryField = this.component.find('[data-dough-salary-input]');
      this.employeeTip = this.component.find('[data-dough-employee-tip]');
      this.employeeTip_lt5876 = this.component.find('[data-dough-employee-tip-lt5876]');
      this.employerTip = this.component.find('[data-dough-employer-tip]');
      this.employeeContributions = this.component.find('[data-dough-employee-contributions]');
      this.employerContributions = this.component.find('[data-dough-employer-contributions]');
      clock = sinon.useFakeTimers();
      this.obj.init();
    });

    afterEach(function() {
      clock.restore();
    });

    it('Has saved state to local storage', function(done) {
      this.salaryField.val('3000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(localStorage.getItem('lt5876')).to.equal('true');
      done();
    });

    it('Adjusts the default contribution values', function(done) {
      this.salaryField.val('3000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);

      if (localStorage.getItem('lt5876') == 'true') {
        expect(this.employeeContributions.val()).to.equal('1');
        expect(this.employerContributions.val()).to.equal('0');
      }

      done();
    })

    it('Updates the employee contribution tip', function(done) {
      this.salaryField.val('3000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(this.employeeTip_lt5876.hasClass('is-hidden')).to.be.false;
      done(); 
    })

    it('Hides the employer contribution tip', function(done) {
      this.salaryField.val('3000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(this.employerTip.text()).to.equal('');
      done(); 
    })
  });

  describe('When user proceeds to step 2 with salary above £5876', function() {
    var clock;

    beforeEach(function() {
      this.salaryField = this.component.find('[data-dough-salary-input]');
      this.employeeContributions = this.component.find('[data-dough-employee-contributions]');
      this.employerContributions = this.component.find('[data-dough-employer-contributions]');
      this.employeeTip = this.component.find('[data-dough-employee-tip]');
      this.employeeTip_lt5876 = this.component.find('[data-dough-employee-tip-lt5876]');
      this.employerTip = this.component.find('[data-dough-employer-tip]');
      clock = sinon.useFakeTimers();
      this.obj.init();
    });

    it('Has not saved state to local storage', function(done) {
      this.salaryField.val('6000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(localStorage.getItem('lt5876')).to.equal(null);
      done();
    });

    it('Shows the original contribution values', function(done) {
      this.salaryField.val('6000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(this.employeeContributions.val()).to.equal('1');
      expect(this.employerContributions.val()).to.equal('1');
      done();
    });

    it('Displays the correct contribution tips', function(done) {
      this.salaryField.val('6000');
      this.salaryField.trigger('keyup');
      clock.tick(this.delay);
      expect(this.employeeTip.hasClass('is-hidden')).to.be.false;
      expect(this.employeeTip_lt5876.hasClass('is-hidden')).to.be.true;
      expect(this.employerTip.text()).to.not.equal(null);
      done();
    });
  });
});
