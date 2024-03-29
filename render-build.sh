#!/usr/bin/env bash
# exit on error
# rails secret | xclip -selection clipboard

set -o errexit

bundle install
RAILS_ENV=production bin/rails assets:precompile
./bin/rails assets:clean

./bin/rails db:migrate

# rails server -e production