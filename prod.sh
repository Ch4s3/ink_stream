#!/bin/bash
function reset_env {
  echo "Resetting env to development"
  export RAILS_ENV=''
  export DISABLE_DATABASE_ENVIRONMENT_CHECK=0
  rm -rf public/assets/
}
trap reset_env EXIT
export RAILS_ENV=production
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1
bundle
rails db:reset
rails assets:precompile
echo "Running Rails"
SECRET_KEY_BASE=test rails s