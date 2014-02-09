# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
NSCD::Application.config.secret_key_base = '92bfa90aa13104892663b83a53cb7aa263e052135fc1abec2e53e55ff8da145631d360a534ec149fbb837b913d975cd18eff75f8b70caa39947fb818a22a7878'
