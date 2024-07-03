set -o errexit

bundle install
bundle exec rails assets:clean
bundle exec rails assets:precompile
bundle exec rake db:migrate
bundle exec rails db:seed