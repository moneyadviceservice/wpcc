describe('Conditional Messaging', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    requirejs(
      ['jquery', 'ConditionalMessaging'],
      function($, ConditionalMessaging) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/ConditionalMessaging.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="ConditionalMessaging"]');
        _this.conditionalMessaging = ConditionalMessaging;
        _this.obj = new _this.conditionalMessaging(_this.component);

        done();
      }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('When age and/or gender fields are changed', function() {
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

      this.ageField = this.component.find('[data-wpcc-age-field]');
      this.genderField = this.component.find('[data-wpcc-gender-select]');
      this.callout_lt16 = this.component.find('[data-wpcc-callout-lt16]');
      this.callout_optIn = this.component.find('[data-wpcc-callout-optIn]');
      this.callout_gt74 = this.component.find('[data-wpcc-callout-gt74]');
      this.submit = this.component.find('[data-wpcc-submit]');

      this.obj.init();
    });

    describe('Only one field has a value', function() {
      it('Displays the correct message', function() {
        this.genderField.val(null);
        this.triggerKeyUp(this.ageField, 15);

        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;

        this.ageField.val(null);
        this.triggerChange(this.genderField, 'male');

        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
      });
    });

    describe('Both fields have values', function() {
      it('Displays the correct message', function() {
        // age: <16
        this.ageField.val(15);
        this.triggerChange(this.genderField, 'male');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerChange(this.genderField, 'female');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        // age: 16-21
        this.triggerKeyUp(this.ageField, 16);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerChange(this.genderField, 'male');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerKeyUp(this.ageField, 21);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerChange(this.genderField, 'female');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        // age: 22-65; gender: female
        this.triggerKeyUp(this.ageField, 63);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerKeyUp(this.ageField, 22);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        // age: 22-64; gender: male
        this.triggerChange(this.genderField, 'male');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerKeyUp(this.ageField, 64);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        // age: 66-74; gender: male
        this.triggerKeyUp(this.ageField, 66);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerKeyUp(this.ageField, 74);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        // age: 66-74; gender: female
        this.triggerChange(this.genderField, 'female');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        this.triggerKeyUp(this.ageField, 66);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.true;

        // age: 75+
        this.triggerKeyUp(this.ageField, 75);

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.false;

        this.triggerChange(this.genderField, 'male');

        expect(this.callout_lt16.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_lt16.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_optIn.hasClass('details__callout--active')).to.be.false;
        expect(this.callout_optIn.hasClass('details__callout--inactive')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--active')).to.be.true;
        expect(this.callout_gt74.hasClass('details__callout--inactive')).to.be.false;
      });
    });
  });
});
