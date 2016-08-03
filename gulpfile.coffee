gulp = require('gulp')
fs = require('fs')
path = require('path')
$ = require('gulp-load-plugins')()

surroundTags =
  css: '<style>'
  js: '<script>'

components = ->
  fs.readdirSync 'components'
    .filter (file) ->
      fs.statSync(path.join('components', file)).isDirectory()

contentsOnly = (filePath, file) ->
  extension = path.extname(filePath).slice(1)
  tag = surroundTags[extension] || ''
  "#{tag} #{file.contents.toString('utf8')} #{tag.replace('<', '</')}"

gulp.task 'styles', ->
  gulp.src 'components/**/*.scss'
    .pipe $.sass()
      .on 'error', $.util.log
    .pipe gulp.dest('build/')

gulp.task 'scripts', ->
  gulp.src 'components/**/*.coffee'
    .pipe $.coffee()
      .on 'error', $.util.log
    .pipe $.uglify()
      .on 'error', $.util.log
    .pipe gulp.dest('build/')

gulp.task 'markups', ->
  gulp.src 'components/**/*.haml'
    .pipe $.haml()
      .on 'error', $.util.log
    .pipe gulp.dest('build/')

gulp.task 'components', ['styles', 'scripts', 'markups'], ->
  injectOptions =
    transform: contentsOnly
    quiet: true
    removeTags: true

  components().map (component) ->
    gulp.src 'components/component.html'
      .pipe $.inject(gulp.src(path.join('build', component, '*.css')), injectOptions )
      .pipe $.inject(gulp.src(path.join('build', component, '*.js')), injectOptions )
      .pipe $.inject(gulp.src(path.join('build', component, '*.html')), injectOptions )
      .pipe $.rename(component + '.html')
      .pipe gulp.dest(path.join('dist'))
        .on 'end', -> $.util.log('Componentized ', component)