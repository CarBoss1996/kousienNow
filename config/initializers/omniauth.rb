Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    redirect_uri: Rails.env.development? ? 'http://localhost:3000/users/auth/google_oauth2/callback' : 'https://kousiennow.onrender.com/users/auth/google_oauth2/callback'
  }
end
