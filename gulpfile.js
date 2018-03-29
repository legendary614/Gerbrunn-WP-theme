var gulp = require("gulp");
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var nunjucks = require('gulp-nunjucks');

// Styles task
//******************************************
gulp.task("styles",function () {
    gulp.src('./src/scss/main.scss')
        .pipe(sass())
        .pipe(
            postcss([
                autoprefixer({browsers: ['last 2 versions', 'ie >= 9', 'Android >= 4.1', 'Safari >= 8', 'iOS >= 7']})
            ]))
        .pipe(gulp.dest('./dist/assets/css'))
});

gulp.task("copy-styles",function () {
    return gulp.src([
    ])
    .pipe(gulp.dest('./dist/assets/css/'));
});


// Copy fonts
//******************************************
gulp.task('fonts', function() {
    return gulp.src([
    ])
        .pipe(gulp.dest('./dist/assets/fonts/'));
});

// Script task
//******************************************
gulp.task('scripts', function() {
    return gulp.src(
        [
        ])
        .pipe(gulp.dest('./dist/assets/js/'));
});

gulp.task('images', function () {
    return gulp.src(
        [
        ])
        .pipe(gulp.dest('./dist/assets/img'))
});

// Template build task
//******************************************

gulp.task('compile', function () {
    return gulp.src(['./src/n-templates/*.php', './src/n-templates/style.css'])
    .pipe(nunjucks.compile())
    .pipe(gulp.dest('./dist'))
});

gulp.task("default", ['images','fonts','scripts', 'styles', 'copy-styles', 'compile']);
