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

        _this.$emailLink = _this.component.find('[data-dough-email-link]');

        done();
    }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('Creates email link href from results', function() {
    beforeEach(function() {
      this.obj.init();
    });

    it('Tests the email link is correct', function() {
      var message = '';

      message += '1. Your details: 31 years, male, £50,000 per year, part salary\n\n';
      message += '2. Your contributions: You: 1%, Your employer: 1%\n\n';
      message += '3. Your Results\n';
      message += 'Qualifying earnings: £39,124\n\n';
      message += 'Now\n';
      message += 'Your contribution: £32.60 (includes tax relief of £6.52)\n';
      message += 'Employer\'s contribution: £32.60\n';
      message += 'Total contributions: £65.20\n\n';
      message += 'April 2018 - March 2019\n';
      message += 'Your contribution: £97.81 (includes tax relief of £19.56)\n';
      message += 'Employer\'s contribution: £65.21\n';
      message += 'Total contributions: £163.02\n\n';
      message += 'April 2019 onwards\n';
      message += 'Your contribution: £163.02 (includes tax relief of £32.60)\n';
      message += 'Employer\'s contribution: £97.81\n';
      message += 'Total contributions: £260.83';

      var href = 'mailto:?body=' + encodeURIComponent(message);

      expect(this.$emailLink.prop('href')).to.equal(href);
    });
  });
});
