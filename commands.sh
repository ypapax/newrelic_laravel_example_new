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

publish() {
  php artisan vendor:publish --provider="Intouch\LaravelNewrelic\NewrelicServiceProvider"
}

rund() {
  NEWRELIC_LICENSE_KEY=$NEWRELIC_LICENSE_KEY docker-compose build
  NEWRELIC_LICENSE_KEY=$NEWRELIC_LICENSE_KEY docker-compose up
}

reqs(){
  while True; do
    curl http://localhost:8011
  done
}

"$@"
