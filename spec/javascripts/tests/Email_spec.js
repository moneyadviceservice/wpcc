describe.only('Email', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    requirejs(
      ['jquery', 'Email'],
      function($, Email) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/Email.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="Email"]');
        _this.email = Email;
        _this.obj = new _this.email(_this.component);

        _this.resultsTables = _this.$html.find('[data-dough-results-table]');

        done();
    }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('Creates content from values in fixture', function() {
    it('Does nothing yet', function() {
      this.obj.init();

      console.log(this.component);

      expect(1).to.equal(1);
    });
  });
});
