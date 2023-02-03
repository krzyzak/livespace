# frozen_string_literal: true

require "singleton"

module Livespace
  class Connection
    include Singleton

    def post(path, data = {})
      request
        .post(full_url(path), json: data.merge(auth_hash))
        .tap { reset_token! }
        .then { |response| JSON.parse(response.body.to_s, symbolize_names: true) }
        .then { |response| handle_response(response) }
    end

    private

    def handle_response(response)
      return response[:data] if response[:result] == 200

      klass = ERROR_MAPPING[response[:result]] || ApiError

      raise klass, response[:error]
    end

    def full_url(path)
      [base_url, path].join("/")
    end

    def auth_data
      @auth_data ||= request
        .post(full_url("_Api/auth_call/_api_method/getToken"), json: raw_auth_hash)
        .then { |response| JSON.parse(response.body.to_s, symbolize_names: true) }
        .then { |response| handle_response(response) }
    end

    def api_token
      auth_data[:token]
    end

    def session_id
      auth_data[:session_id]
    end

    def api_key
      Livespace.config.api_key || raise(ArgumentError, "Missing API key")
    end

    def api_secret
      Livespace.config.api_secret || raise(ArgumentError, "Missing API secret")
    end

    def domain
      Livespace.config.domain || raise(ArgumentError, "Missing domain")
    end

    def api_sha
      Digest::SHA1.hexdigest([api_key, api_token, api_secret].join)
    end

    def base_url
      @base_url ||= [domain, "api/public/json"].join("/")
    end

    def raw_auth_hash
      @raw_auth_hash ||= {
        _api_auth: :key,
        _api_key: api_key
      }
    end

    def auth_hash
      raw_auth_hash.merge(_api_sha: api_sha, _api_session: auth_data[:session_id])
    end

    def reset_token!
      @auth_data = nil
    end

    def request
      @request ||= HTTP.headers(accept: "application/json")
    end
  end
end
