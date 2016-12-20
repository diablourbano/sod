var gulp = require('gulp');
var gutil = require('gulp-util');
var flatten = require('gulp-flatten');
var concat = require('gulp-concat');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

gulp.task('default', ['addMap', 'variables:dev', 'loadLibraries', 'coffee:watch', 'sass:watch', 'fonts:watch', 'index:watch']);
gulp.task('dist', ['map:dist', 'variables:dist', 'libraries:dist', 'js:dist', 'css:dist', 'fonts:dist', 'index:dist']);

gulp.task('coffee', function() {
  return gulp.src('./js/**/**.coffee')
      .pipe(flatten())
      .pipe(coffee({bare: true}).on('error', gutil.log))
      .pipe(gulp.dest('./tmp/'));
});

gulp.task('merge-js', ['coffee'], function() {
  filesOrder = [
    './tmp/en.js',
    './tmp/es.js',
    './tmp/fr.js',
    './tmp/locale_ui.js',
    './tmp/utils.js',
    './tmp/url-manager.js',
    './tmp/events-manager.js',
    './tmp/transitions.js',
    './tmp/map.js',
    './tmp/axis.js',
    './tmp/years.js',
    './tmp/months.js',
    './tmp/days.js',
    './tmp/dots.js',
    './tmp/timeline.js',
    './tmp/views.main.js',
  ]

  gulp.src(filesOrder)
             .pipe(concat('sod.js'))
             .pipe(gulp.dest(('./build')))
});

gulp.task('coffee:watch', function() {
  gulp.watch('./js/**/**.coffee', ['merge-js']);
});

gulp.task('sass', function () {
  gulp.src('./stylesheets/**/**.scss')
      .pipe(sass().on('error', sass.logError))
      .pipe(gulp.dest('./build'));
});
     
gulp.task('sass:watch', function () {
  gulp.watch('./stylesheets/**/**.scss', ['sass']);
});

gulp.task('fonts:build', function() {
  gulp.src('./fonts/**/**.*')
      .pipe(gulp.dest('./build/fonts'));
});

gulp.task('fonts:watch', function() {
  gulp.watch('./fonts/**/**.*', ['fonts:build']);
});

gulp.task('index', function() {
  gulp.src('./index.html')
      .pipe(gulp.dest(('./build')));
});

gulp.task('index:watch', function() {
  gulp.watch('./index.html', ['index']);
});

gulp.task('addMap', function() {
  gulp.src('./js/data/map.json')
      .pipe(gulp.dest(('./build')))
});

gulp.task('variables:dev', function() {
  gulp.src('./js/dev_env_vars.js')
      .pipe(rename('env_vars.js'))
      .pipe(gulp.dest(('./build')))
});

gulp.task('loadLibraries', function() {
  librariesToInclude = [
    './bower_components/lodash/dist/lodash.min.js',
    './bower_components/jquery/dist/jquery.min.js',
    './bower_components/perfect-scrollbar/js/perfect-scrollbar.jquery.min.js',
    './bower_components/momentjs/min/moment.min.js',
    './bower_components/topojson/topojson.js',
    './bower_components/d3/d3.min.js',
  ]

  return gulp.src(librariesToInclude)
             .pipe(concat('libraries.js'))
             .pipe(gulp.dest(('./build')))
});

/* DIST  */

gulp.task('index:dist', function() {
  gulp.src('./build/index.html')
      .pipe(gulp.dest(('./dist')));
});

gulp.task('css:dist', function() {
  gulp.src('./build/map.css')
      .pipe(gulp.dest(('./dist')));
});

gulp.task('map:dist', function() {
  gulp.src('./build/map.json')
      .pipe(gulp.dest(('./dist')));
});

gulp.task('variables:dist', function() {
  gulp.src('./js/dist_env_vars.js')
      .pipe(rename('env_vars.js'))
      .pipe(gulp.dest(('./dist')));
});

gulp.task('libraries:dist', function() {
  gulp.src('./build/libraries.js')
      .pipe(gulp.dest(('./dist')));
});

gulp.task('js:dist', function() {
  gulp.src('./build/sod.js')
      .pipe(uglify())
      .pipe(gulp.dest('./dist'))
});
