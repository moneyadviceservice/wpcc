var allTestFiles = []
var TEST_REGEXP = /(spec|test)\.js$/i

// Get a list of all the test files to include
Object.keys(window.__karma__.files).forEach(function (file) {
  if (TEST_REGEXP.test(file)) {
    // Normalize paths to RequireJS module names.
    // If you require sub-dependencies of test files to be loaded as-is (requiring file extension)
    // then do not normalize the paths
    var normalizedTestModule = file.replace(/^\/base\/|\.js$/g, '')
    allTestFiles.push(normalizedTestModule)
  }
})

require.config({
  // Karma serves files under /base, which is the basePath from your config file
  baseUrl: '/base',

  // dynamically load all test files
  deps: allTestFiles,

  // we have to kickoff jasmine, as it is asynchronous
  callback: window.__karma__.start,

  paths: {
    // External dependancies
    jquery: 'vendor/assets/bower_components/jquery/dist/jquery',

    // Internal modules
    DoughBaseComponent: 'vendor/assets/bower_components/dough/assets/js/components/DoughBaseComponent',

    // Dough components
    utilities: 'vendor/assets/bower_components/dough/assets/js/lib/utilities',

    // WPCC components
    ConditionalMessaging: 'app/assets/javascripts/wpcc/components/ConditionalMessaging',
    SalaryConditions: 'app/assets/javascripts/wpcc/components/SalaryConditions',
    ContributionConditions: 'app/assets/javascripts/wpcc/components/ContributionConditions'
  }
})
