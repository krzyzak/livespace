# frozen_string_literal: true

module Livespace
  class Company
    class << self
      def create(data)
        connection.post("Contact/addCompany", data)
      end

      private

      def connection
        Connection.instance
      end
    end
  end
end
