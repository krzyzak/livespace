# frozen_string_literal: true

module Livespace
  # Generic errors
  ApiError = Class.new(StandardError)
  MethodError = Class.new(ApiError)
  ApiHandlingError = Class.new(ApiError)
  AuthorizationMethodError = Class.new(ApiError)

  # Method Errors
  GeneralClientError = Class.new(MethodError)
  ValidationError = Class.new(MethodError)

  # Api Handling Errors
  ServerError = Class.new(ApiHandlingError)
  InvalidModuleError = Class.new(ApiHandlingError)
  InvalidMethodError = Class.new(ApiHandlingError)
  InvalidFormatError = Class.new(ApiHandlingError)
  DatabaseError = Class.new(ApiHandlingError)
  UserNotLoggedInError = Class.new(ApiHandlingError)
  AuthorizationError = Class.new(ApiHandlingError)
  ParameterHandlingError = Class.new(ApiHandlingError)

  # Authorization Errors
  InvalidMethodAuthorizationError = Class.new(AuthorizationMethodError)
  InvalidParameterError = Class.new(AuthorizationMethodError)
  InvalidKeyError = Class.new(AuthorizationMethodError)
  InvalidAuthorizationError = Class.new(AuthorizationMethodError)
  GeneralError = Class.new(AuthorizationMethodError)

  ERROR_MAPPING = {
    400 => GeneralClientError,
    420 => ValidationError,
    500 => ServerError,
    514 => InvalidModuleError,
    515 => InvalidMethodError,
    516 => InvalidFormatError,
    520 => DatabaseError,
    530 => UserNotLoggedInError,
    540 => AuthorizationError,
    550 => ParameterHandlingError,
    560 => InvalidMethodAuthorizationError,
    561 => InvalidParameterError,
    562 => InvalidKeyError,
    563 => InvalidAuthorizationError,
    564 => GeneralError
  }.freeze
end
