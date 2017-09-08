describe('Contribution Conditions', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    requirejs(
      ['jquery', 'ContributionConditions'],
      function($, ContributionConditions) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/ContributionConditions.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="ContributionConditions"]');
        _this.contributionConditions = ContributionConditions;
        _this.obj = new _this.contributionConditions(_this.component);
        done();
      }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('When an employee contribution percentage is entered', function() {
    
    beforeEach(function() {
      this.employeeContributions = this.component.find('[data-wpcc-employee-contributions]');
      this.eligibleSalary = this.component.find('[data-wpcc-contribution-salary]');
      this.contributionWarning = this.component.find('[data-wpcc-callout-contribution-gt40000]');

      this.obj.init();
    });

    describe('When salary contribution is under 40000', function() {
      it('Does not display the callout message', function() {
        this.employeeContributions.val(20);
        this.eligibleSalary.text('£60,000');
        this.employeeContributions.trigger('keyup');
        expect(
          this.contributionWarning.hasClass('details__callout--inactive')
        ).to.be.true;
      });
    });

    describe('When salary contribution is over 40000', function() {
      it('Displays the callout message', function() {
        this.employeeContributions.val(100);
        this.eligibleSalary.text('£60,000');
        this.employeeContributions.trigger('keyup');
        expect(
          this.contributionWarning.hasClass('details__callout--active')
        ).to.be.true;
      });
    });
  });
});
