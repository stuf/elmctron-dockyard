'use strict';

const gulp = require('gulp');
const elm = require('gulp-elm');
const sass = require('gulp-sass');
const cssmin = require('gulp-cssmin');
const browserSync = require('browser-sync');
const prefix = require('gulp-autoprefixer');
const electron = require('electron-connect').server.create();

gulp.task('elm-init', elm.init);

/**
 * Copy HTML and CSS files to app directory.
 */
gulp.task("copy-assets", ['sass'], () =>
  gulp.src(["src/*.html", "src/*.css"])
      .pipe(gulp.dest("app"))
      .pipe(browserSync.reload({stream:true})));

/**
 * Handle SCSS files.
 * Convert SCSS to CSS, minify all the files and add prefix.
 */
gulp.task('sass', () => 
  gulp.src('src/style.scss')
      .pipe(sass({
          includePaths: ['css'],
          onError: browserSync.notify
      }))
      .pipe(prefix(['last 15 versions', '> 1%', 'ie 8', 'ie 7'], { cascade: true }))
      .pipe(cssmin())
      .pipe(gulp.dest('app')));

/**
 * Compile Elm files to JavaScript.
 */
gulp.task('elm', ['elm-init', 'copy-assets'], () =>
  gulp.src('src/**/*.elm')
      .pipe(elm.make({ filetype: 'js' }))
      .pipe(gulp.dest('app/'))
      .pipe(browserSync.reload({stream:true})));

/**
 * Watch HTML and SCSS files for changes and copy them.
 * Watch Elm files, recompile them and reload BrowserSync.
 */
gulp.task('watch', () => {
    gulp.watch(['src/**/*.scss', 'src/*.html'], ['copy-assets']);
    gulp.watch('src/**/*.elm', ['elm']);
});

/**
 * Build the app without watching the files.
 * This task is created for building the app before
 * packaging it inside the Electron dist apps.
 */
gulp.task('build', ['elm']);

/**
 * Default task, running just `gulp` will compile the SCSS,
 * HTML, and Elm, launch BrowserSync and watch files in Electron.
 */
gulp.task('default', ['elm', 'watch'], () =>
  // Start browser process
  electron.start());
