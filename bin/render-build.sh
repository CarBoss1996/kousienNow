set -o errexit

bundle install
bundle exec rails assets:clean
bundle exec rails assets:precompile
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:migrate:reset