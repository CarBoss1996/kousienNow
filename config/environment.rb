# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
# config/environment.rb
Rails.application.config.secret_key_base = Rails.application.credentials.secret_key_base
