# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_usando_authlogic_session',
  :secret      => '566ce8874245b296e90c14754dbe74af7d6b3ba2285498432ef2987fe07f6d9d22f005beb2de27ad8710cf1718ea0fe02303c1e3a9aad7a387fa53085db17616'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
