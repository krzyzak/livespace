# frozen_string_literal: true

RSpec.describe Livespace::Connection do
  before do
    stub_request(:post, "https://myapp.livespace.io/api/public/json/_Api/auth_call/_api_method/getToken")
      .to_return(body: { data: { token: "some-token", session_id: "some-session-id" }, result: 200 }.to_json)
  end

  describe "error handling" do
    before do
      Livespace.configure do |config|
        config.api_key = "some-api-key"
        config.api_secret = "some-api-secret"
        config.domain = "https://myapp.livespace.io"
      end

      stub_request(:post, "https://myapp.livespace.io/api/public/json/some/module")
        .to_return(body: { result: error_code }.to_json, status: error_code)
    end

    subject { described_class.instance.post("some/module") }

    context "with method errors" do
      context "with a general client error" do
        let(:error_code) { 400 }

        it "raises a GeneralClientError" do
          expect { subject }.to raise_error(Livespace::GeneralClientError)
        end
      end

      context "with a validation error" do
        let(:error_code) { 420 }

        it "raises a ValidationError" do
          expect { subject }.to raise_error(Livespace::ValidationError)
        end
      end
    end

    context "with API handling errors" do
      context "with a server error" do
        let(:error_code) { 500 }

        it "raises a ServerError" do
          expect { subject }.to raise_error(Livespace::ServerError)
        end
      end

      context "with an invalid module error" do
        let(:error_code) { 514 }

        it "raises an InvalidModuleError" do
          expect { subject }.to raise_error(Livespace::InvalidModuleError)
        end
      end

      context "with an invalid method error" do
        let(:error_code) { 515 }

        it "raises an InvalidMethodError" do
          expect { subject }.to raise_error(Livespace::InvalidMethodError)
        end
      end

      context "with an invalid format error" do
        let(:error_code) { 516 }

        it "raises an InvalidFormatError" do
          expect { subject }.to raise_error(Livespace::InvalidFormatError)
        end
      end

      context "with a database error" do
        let(:error_code) { 520 }

        it "raises a DatabaseError" do
          expect { subject }.to raise_error(Livespace::DatabaseError)
        end
      end

      context "with a user not logged in error" do
        let(:error_code) { 530 }

        it "raises a UserNotLoggedInError" do
          expect { subject }.to raise_error(Livespace::UserNotLoggedInError)
        end
      end

      context "with an authorization error" do
        let(:error_code) { 540 }

        it "raises an AuthorizationError" do
          expect { subject }.to raise_error(Livespace::AuthorizationError)
        end
      end

      context "with a parameter handling error" do
        let(:error_code) { 550 }

        it "raises a ParameterHandlingError" do
          expect { subject }.to raise_error(Livespace::ParameterHandlingError)
        end
      end
    end

    context "with authorization errors" do
      context "with an invalid method authorization error" do
        let(:error_code) { 560 }

        it "raises an InvalidMethodAuthorizationError" do
          expect { subject }.to raise_error(Livespace::InvalidMethodAuthorizationError)
        end
      end

      context "with an invalid parameter error" do
        let(:error_code) { 561 }

        it "raises an InvalidParameterError" do
          expect { subject }.to raise_error(Livespace::InvalidParameterError)
        end
      end

      context "with an invalid key error" do
        let(:error_code) { 562 }

        it "raises an InvalidKeyError" do
          expect { subject }.to raise_error(Livespace::InvalidKeyError)
        end
      end

      context "with an invalid authorization error" do
        let(:error_code) { 563 }

        it "raises an InvalidAuthorizationError" do
          expect { subject }.to raise_error(Livespace::InvalidAuthorizationError)
        end
      end

      context "with a general error" do
        let(:error_code) { 564 }

        it "raises a GeneralError" do
          expect { subject }.to raise_error(Livespace::GeneralError)
        end
      end
    end
  end
end
