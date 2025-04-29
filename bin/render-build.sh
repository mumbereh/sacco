#!/usr/bin/env bash

# Exit on error
set -o errexit

# Ensure RAILS_MASTER_KEY is set (used to decrypt credentials)
if [ -z "$RAILS_MASTER_KEY" ]; then
  echo "RAILS_MASTER_KEY is missing. Please set it in Render > Environment."
  exit 1
fi

# Install Ruby gems
bundle install

# Compile assets
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Run DB migrations
bundle exec rails db:migrate
