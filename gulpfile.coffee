gulp = require 'gulp'

source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'
coffeeify  = require 'coffeeify'
browserify   = require 'browserify'

jade = require 'gulp-jade'
stylus = require 'gulp-stylus'
reload = require 'gulp-livereload'

sourcemaps = require 'gulp-sourcemaps'

autowatch = require 'gulp-autowatch'


# paths
paths =
  vendor: './client/vendor/**/*'
  img: './client/img/**/*'
  fonts: './client/fonts/**/*'
  stylus: './client/**/*.styl'
  bundle: './client/index.coffee'
  coffee: './client/**/*.coffee'
  stylusSrc: './client/widget.styl'
  jade: './client/*.jade'
  public: './widget'

# javascript
gulp.task 'coffee', ->
  bCache = {}
  b = browserify paths.bundle,
    debug: true
    insertGlobals: true
    cache: bCache
    extensions: ['.coffee']
  b.transform coffeeify
  b.bundle()
  .pipe source 'index.js'
  .pipe buffer()
  .pipe gulp.dest paths.public
  .pipe reload()

# styles
gulp.task 'stylus', ->
  gulp.src paths.stylusSrc
    .pipe sourcemaps.init()
    .pipe stylus()
    .pipe sourcemaps.write()
    .pipe gulp.dest paths.public
    .pipe reload()

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe jade()
    .pipe gulp.dest paths.public
    .pipe reload()

gulp.task 'vendor', ->
  gulp.src paths.vendor
    .pipe gulp.dest "#{paths.public}/vendor"
    .pipe reload()

gulp.task 'img', ->
  gulp.src paths.img
    .pipe gulp.dest "#{paths.public}/img"
    .pipe reload()

gulp.task 'watch', ->
  autowatch gulp, paths

gulp.task 'css', ['stylus']
gulp.task 'js', ['coffee']
gulp.task 'static', ['jade', 'vendor', 'img']
gulp.task 'default', ['js', 'css', 'static', 'watch']
