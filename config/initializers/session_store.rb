# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_unlock-server_session',
  :secret      => '23246f9c84743bee8d3b816324b06470d825e4ed9261815d8117030971b9bc91e8df56c8ad52311ee03177e139cc3482cb6a809240643d7bd5f0624d1576a8ed'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
