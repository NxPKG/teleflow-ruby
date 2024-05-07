# frozen_string_literal: true

module Teleflow
  class Api
    # Module Teleflow::Api::InboundParse provides an API for managing inbound-parse in the Teleflow application.
    #
    # This module includes method for retrieving inbound-parse.
    #
    # For more information on the Teleflow API(https://api-teleflow.khulnasoft.com/api#/inbound-parse), see https://docs.teleflow.khulnasoft.com/api/overview/.
    module InboundParse
      # Validate the mx record setup for the inbound parse functionality
      def validate_mx_record_setup_for_inbound_parse
        get("/inbound-parse/mx/status")
      end
    end
  end
end
