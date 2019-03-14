// Karma configuration
// Generated on Thu Jun 29 2017 11:49:30 GMT+0100 (BST)

module.exports = function(config) {
  config.set({
    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '../../',

    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['requirejs', 'mocha', 'chai', 'sinon', 'jquery-3.3.1'],

    // list of files / patterns to load in the browser
    files: [
      'spec/javascripts/test-main.js',
      'spec/javascripts/fixtures/*.html',
      {pattern: 'app/assets/javascripts/wpcc/**/*.js', included: false},
      {pattern: 'vendor/assets/bower_components/jquery/**/*.js', included: false},
      {pattern: 'vendor/assets/bower_components/dough/**/*.js', included: false},
      {pattern: 'spec/javascripts/tests/*_spec.js', included: false},
    ],

    // list of files to exclude
    exclude: [
      'app/assets/javascripts/wpcc/application.js'
    ],

    preprocessors: {
       '**/*.html': ['html2js']
    },

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['spec'],

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,

    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS'],

    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: true,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}
