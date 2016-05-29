var gulp = require('gulp');
var gutil = require('gulp-util');
var flatten = require('gulp-flatten');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');

gulp.task('default', ['coffee:watch', 'sass:watch', 'index:watch']);

gulp.task('coffee', function() {
  gulp.src('./js/**/**.coffee')
      .pipe(flatten())
      .pipe(coffee({bare: true}).on('error', gutil.log))
      .pipe(gulp.dest('./build/'));
});

gulp.task('coffee:watch', function() {
  gulp.watch('./js/**/**.coffee', ['coffee']);
});

gulp.task('sass', function () {
  gulp.src('./scss/**/**.scss')
      .pipe(sass().on('error', sass.logError))
      .pipe(gulp.dest('./build'));
});
     
gulp.task('sass:watch', function () {
  gulp.watch('./scss/**/**.scss', ['sass']);
});

gulp.task('index', function() {
  gulp.src('./index.html')
      .pipe(gulp.dest('./build'));
});

gulp.task('index:watch', function() {
  gulp.watch('./index.html', ['index']);
});
