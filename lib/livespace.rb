# frozen_string_literal: true

require "dry-configurable"
require "http"

require "livespace/connection"
require "livespace/company"
require "livespace/errors"
require "livespace/version"

module Livespace
  extend Dry::Configurable

  setting :domain, default: ENV["LIVESPACE_DOMAIN"]
  setting :api_key, default: ENV["LIVESPACE_API_KEY"]
  setting :api_secret, default: ENV["LIVESPACE_API_SECRET"]
end
