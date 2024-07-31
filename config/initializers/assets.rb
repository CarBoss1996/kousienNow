# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('node_modules/bootstrap-icons/font')
Rails.application.config.assets.paths << Rails.root.join('node_modules/@hotwired/turbo-rails/dist')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'javascripts')
Rails.application.config.assets.precompile += Dir[Rails.root.join('app', 'assets', 'images', 'icons', '*')].map{ |path| "icons/#{File.basename(path, File.extname(path))}" }
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
Rails.application.config.assets.precompile += %w( adminLTE.js adminlte.scss )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
