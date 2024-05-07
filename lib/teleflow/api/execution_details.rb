# frozen_string_literal: true

module Teleflow
  class Api
    # Module Teleflow::Api::ExecutionDetails provides an API for managing execution details in the Teleflow application.
    #
    # This module includes method for retrieving execution details.
    #
    # For more information on the Teleflow API(https://api-teleflow.khulnasoft.com/api#/Execution%20Details), see https://docs.teleflow.khulnasoft.com/api/get-execution-details/.
    module ExecutionDetails
      # Returns a list of execution details
      #
      # @queryparams:
      # @param `notificationId` [String]
      # @param `subscriberId` [String]
      #
      # @return [Hash] The list of execution details that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def execution_details(query = {})
        get("/execution-details", query: query)
      end
    end
  end
end
