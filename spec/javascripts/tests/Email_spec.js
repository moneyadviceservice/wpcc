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

      var message =
        '1. Your details: 31 years, male, £50,000 per year, part salary' +
        '2. Your contributions: You: 1%, Your employer: 1%' +
        '3. Results:' +
        'Qualifying Earnings: £39,124' +
        'Now:' +
        'Your contribution: £32.60' +
        '(includes tax relief of £6.52)' +
        'Employer\'s contribution: £32.60' +
        'Total contributions: £65.20' +
        'April 2018 - March 2019:' +
        'Your contribution: £97.81' +
        '(includes tax relief of £19.56)' +
        'Employer\'s contribution: £65.21' +
        'Total contributions: £163.02' +
        'April 2019 onwards:' +
        'Your contribution: £163.02' +
        '(includes tax relief of £32.60)' +
        'Employer\'s contribution: £97.81' +
        'Total contributions: £260.83';

      expect(1).to.equal(1);
    });
  });
});
