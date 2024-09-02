set -o errexit

bundle install
bundle exec rails assets:clean
bundle exec rails assets:precompile

if bundle exec rake db:migrate:status | grep -q 'down'; then
  bundle exec rake db:migrate
fi

bundle exec rails db:seed