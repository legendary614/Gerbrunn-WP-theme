#!/bin/sh

cd /var/www/builddir
npm install
npm update
node node_modules/gulp/bin/gulp.js

sleep 1

mv dist /var/www/html/wp-content/themes/gerbrunn
