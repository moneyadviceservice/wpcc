describe('Blank Test', function() {
  'use strict';

  beforeEach(function() {
    var _this = this;

    requirejs(
      ['jquery', 'BlankTest'],
      function($, BlankTest) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/BlankTest.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="BlankTest"]');
        _this.blankTest = BlankTest;
        _this.obj = new _this.blankTest(_this.component);
      });
  });

  describe('blank test', function() {
    it('does nothing', function() {
      expect(1).to.equal(1);
    });
  });
});
