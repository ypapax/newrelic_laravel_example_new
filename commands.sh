#!/usr/bin/env bash
set -ex
set -o pipefail

PORT=8088

dev() {
  php artisan serve --port $PORT
}

req() {
  curl http://localhost:$PORT
}

installNewRelic() {
#  https://github.com/In-Touch/laravel-newrelic#laravel-4x-support
  composer require intouch/laravel-newrelic
}

"$@"
