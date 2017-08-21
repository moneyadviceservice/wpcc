describe('Step Transition', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    requirejs(
      ['jquery', 'StepTransition'],
      function($, StepTransition) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/StepTransition.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="StepTransition"]');
        _this.stepTransition = StepTransition;
        _this.obj = new _this.stepTransition(_this.component);

        done();
      }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('When Step 1 is completed', function() {
    beforeEach(function() {

      this.detailsForm = this.component.find('[data-dough-details-form]');
      this.detailsSubmit = this.component.find('[data-dough-details-submit]');

      this.obj.init();
    });

    describe('Submit button is clicked on step 1', function() {
      it('Posts to the server using ajax', function() {

        this.detailsSubmit.click();

      });

      it('Receives a JSON response', function() {

      });

      it('Hides the your details step', function() {
        this.detailsSubmit.click();
        expect(this.detailsForm.hasClass('form--active')).to.be.true
      });

      it('Shows the your contributions step', function() {

      });
    });

  });    
});
