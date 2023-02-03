# frozen_string_literal: true

require "dry-configurable"

require "livespace/connection"
require "livespace/errors"
require "livespace/version"

module Livespace
  extend Dry::Configurable

  setting :domain
  setting :api_key
  setting :api_secret
end
