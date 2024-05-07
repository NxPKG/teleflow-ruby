# frozen_string_literal: true

module Teleflow
  class Api
    # Module Teleflow::Api::NotificationGroups provides an API for managing notification groups in the Teleflow application.
    #
    # This module includes methods for creating, retrieving notification groups.
    #
    # For more information on the Teleflow API(https://api-teleflow.khulnasoft.com/api#/Notification%20groups), see https://docs.teleflow.khulnasoft.com/api/create-notification-group/.
    module NotificationGroups
      # Creates a notification group.
      #
      # @bodyparams:
      # @param `name` [String] User defined custom name and provided by the user that will name the notification group created.
      #
      # @return [Hash] The created notification group entity.
      # @return [number] status - The status code. Returns 201 if the notification group has been successfully created.
      def create_notification_group(body)
        post("/notification-groups", body: body)
      end

      # Returns a list of notification groups
      #
      # @return [Hash] list of notification groups.
      # @return [number] status
      #  - Returns 200 if successful
      def notification_groups
        get("/notification-groups")
      end
    end
  end
end
