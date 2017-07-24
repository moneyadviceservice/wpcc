describe('Update Results', function() {
  'use strict';

  beforeEach(function(done) {
    var _this = this;

    // change frequency function
    this.triggerChange = function(element, value) {
      var e = $.Event('change');
      $(element).val(value);
      element.trigger(e);
    };

    requirejs(
      ['jquery', 'UpdateResults'],
      function($, UpdateResults) {
        _this.$html = $(window.__html__['spec/javascripts/fixtures/UpdateResults.html']).appendTo('body');
        _this.component = _this.$html.find('[data-dough-component="UpdateResults"]');
        _this.updateResults = UpdateResults;
        _this.obj = new _this.updateResults(_this.component);
        _this.frequencySelector = _this.$html.find('[data-dough-selector]');
        _this.resultsTables = _this.$html.find('[data-dough-results-table]');

        done();
    }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('Sets up initial values', function() {
    // Initial Values
    var initialValues = {
      year: {
        employeeContributions: ['191.24', '573.72', '956.2'],
        taxRelief: ['38.25', '114.74', '191.24'],
        employerContributions: ['191.24', '382.48', '573.72']
      },
      month: {
        employeeContributions: ['15.94', '47.81', '79.68'],
        taxRelief: ['3.19', '9.56', '15.94'],
        employerContributions: ['15.94', '31.87', '47.81']
      },
      fourweeks: {
        employeeContributions: ['14.71', '44.13', '73.55'],
        taxRelief: ['2.94', '8.83', '14.71'],
        employerContributions: ['14.71', '29.42', '44.13']
      },
      week: {
        employeeContributions: ['3.68', '11.03', '18.39'],
        taxRelief: ['0.74', '2.21', '3.68'],
        employerContributions: ['3.68', '7.36', '11.03']
      }
    };

    for (var initialFrequency in initialValues) {
      setUpInitialState(initialFrequency, initialValues[initialFrequency]);
    }

    function setUpInitialState(initialFrequency, values) {
      beforeEach(function () {
        // add intial values to fixture
        for (var i = 0, max = this.resultsTables.length; i < max; i++) {
          $(this.resultsTables[i]).find('[data-dough-employee-contribution]').attr('data-value', values.employeeContributions[i]);
          $(this.resultsTables[i]).find('[data-dough-tax-relief]').attr('data-value', values.taxRelief[i]);
          $(this.resultsTables[i]).find('[data-dough-employer-contribution]').attr('data-value', values.employerContributions[i]);
        }

        // intialise the component
        this.obj.init();
      });

      describe('Tests the calculated values', function() {
        // Expected Values
        var expectedValues = {
          year: {
            employeeContributions: ['£191.24', '£573.72', '£956.20'],
            taxRelief: ['(includes tax relief of £38.25)', '(includes tax relief of £114.74)', '(includes tax relief of £191.24)'],
            employerContributions: ['£191.24', '£382.48', '£573.72'],
            total: ['£382.48', '£956.20', '£1,529.92']
          },
          month: {
            employeeContributions: ['£15.94', '£47.81', '£79.68'],
            taxRelief: ['(includes tax relief of £3.19)', '(includes tax relief of £9.56)', '(includes tax relief of £15.94)'],
            employerContributions: ['£15.94', '£31.87', '£47.81'],
            total: ['£31.87', '£79.68', '£127.49']
          },
          fourweeks: {
            employeeContributions: ['£14.71', '£44.13', '£73.55'],
            taxRelief: ['(includes tax relief of £2.94)', '(includes tax relief of £8.83)', '(includes tax relief of £14.71)'],
            employerContributions: ['£14.71', '£29.42', '£44.13'],
            total: ['£29.42', '£73.55', '£117.69']
          },
          week: {
            employeeContributions: ['£3.68', '£11.03', '£18.39'],
            taxRelief: ['(includes tax relief of £0.74)', '(includes tax relief of £2.21)', '(includes tax relief of £3.68)'],
            employerContributions: ['£3.68', '£7.36', '£11.03'],
            total: ['£7.36', '£18.39', '£29.42']
          }
        };

        for (var frequency in expectedValues) {
          // don't change from initial value to the same value
          if (frequency !== initialFrequency) {
            testExpected(frequency, expectedValues[frequency]);
          }
        }

        function testExpected(frequency, values) {
          it('Initial frequency set to ' + initialFrequency + ', changed to ' + frequency, function() {
            this.triggerChange(this.frequencySelector, frequency);

            for (var i = 0, max = this.resultsTables.length; i < max; i++) {
              expect($(this.resultsTables[i]).find('[data-dough-employee-contribution]').html()).to.equal(values.employeeContributions[i]);
              expect($(this.resultsTables[i]).find('[data-dough-tax-relief]').html()).to.equal(values.taxRelief[i]);
              expect($(this.resultsTables[i]).find('[data-dough-employer-contribution]').html()).to.equal(values.employerContributions[i]);
              expect($(this.resultsTables[i]).find('[data-dough-total]').html()).to.equal(values.total[i]);
            };
          });
        }
      });
    }
  });
});
