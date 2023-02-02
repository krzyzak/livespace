# frozen_string_literal: true

require "livespace/version"
require "dry-configurable"

module Livespace
  extend Dry::Configurable

  setting :domain
  setting :api_key
  setting :api_secret
end
