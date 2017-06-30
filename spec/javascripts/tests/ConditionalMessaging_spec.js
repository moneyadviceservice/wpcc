describe('ConditionalMessaging', function() {
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

  describe('First test', function() {
    it('does nothing', function() {
      this.obj.init();

      expect(2).to.be.equal(2);
    });
  });
});
