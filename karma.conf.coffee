module.exports = (config) ->
  config.set
     files: [
      'node_modules/webcomponents.js/webcomponents.min.js',
      'dist/**/*.html',
      'components/**/*.spec.coffee'
     ]

     exclude: ['dist/**/*.vulcanized.html']

     reporters: ['progress']

     logLevel: config.LOG_WARN

     singleRun: true

     autoWatch: false

     frameworks: ['jasmine']

     browsers: ['PhantomJS']

     preprocessors:
      '**/*.coffee': ['coffee']

     plugins: [
      'karma-coffee-preprocessor',
      'karma-phantomjs-launcher',
      'karma-jasmine'
     ]
