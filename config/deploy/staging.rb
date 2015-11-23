# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

user = "ubuntu"
ip_address = "52.29.19.124"


role :app, ["#{user}@#{ip_address}"]
role :web, ["#{user}@#{ip_address}"]
role :db,  ["#{user}@#{ip_address}"]


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server ip_address,
  user: user,
  roles: %w{web app},
  my_property: :my_value


set :rails_env, 'production'

set :bundle_flags, "--no-deployment"

set :ssh_options, {
  keys: %w(~/.ssh/ciaobox.pem),
  forward_agent: true,
}

set :nginx_server_name, 'ciaobox.it ciaobox.org ciaobox.fr ciaobox.es ciaobox.de ciaobox.co.uk ciaobox.ch'
