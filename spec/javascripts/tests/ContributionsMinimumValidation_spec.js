describe('Contributions Minimum Validation', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    requirejs(
      ['jquery', 'ContributionsMinimumValidation'],
      function($, ContributionsMinimumValidation) {
        _this.$html = $(
          window.__html__[
            'spec/javascripts/fixtures/ContributionsMinimumValidation.html'
          ]
        ).appendTo('body');
        _this.component = _this.$html.find(
          '[data-dough-component="ContributionsMinimumValidation"]'
        );
        _this.ContributionsMinimumValidation = ContributionsMinimumValidation;
        _this.obj = new _this.ContributionsMinimumValidation(_this.component);
        done();
      },
      done
    );
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('When contributions fields are changed', function() {
    beforeEach(function() {
      this.triggerKeyUp = function(element, keyCode) {
        var e = $.Event('keyup');
        e.which = keyCode;
        $(element).val(e.which);
        element.trigger(e);
      };

      this.triggerChange = function(element, value) {
        var e = $.Event('change');
        $(element).val(value);
        element.trigger(e);
      };

      this.employeeContributionsField = this.component.find(
        '[data-wpcc-employee-contributions]'
      );
      this.employerContributionsField = this.component.find(
        '[data-wpcc-employer-contributions]'
      );
      this.submit = $('[data-wpcc-submit]');
      this.errorMessage = $('.minimum-contributions-error');
      this.obj.init();
    });

    describe('The total combinations are greater than or equal to 8', function() {
      it('Hides the error message and enables the submit button', function() {
        this.employeeContributionsField.val(5);
        this.employerContributionsField.val(3);
        this.triggerChange(this.employeeContributionsField, 5.5);

        expect(this.errorMessage).not.to.be.visible;
        expect(this.submit).not.to.be.disabled;
      });
    });

    describe('The total combinations are less than 8', function() {
      it('Displays the error message and disables the submit button', function() {
        this.employeeContributionsField.val(5);
        this.employerContributionsField.val(3);
        this.triggerChange(this.employeeContributionsField, 4.5);

        expect(this.errorMessage).to.be.visible;
        expect(this.submit).to.be.disabled;
      });
    });
  });
});
