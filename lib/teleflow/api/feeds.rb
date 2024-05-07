# frozen_string_literal: true

module Teleflow
  class Api
    # Module Teleflow::Api::Feeds provides an API for managing feeds in the Teleflow application.
    #
    # This module includes methods for creating, retrieving, and deleting feeds.
    #
    # For more information on the Teleflow API(https://api-teleflow.khulnasoft.com/api#/Feeds), see https://docs.teleflow.khulnasoft.com/api/create-feed/.
    module Feeds
      # Creates a new feed.
      #
      # @bodyparams:
      # @param `name` [String]
      #
      # @return [Hash] Feed entity.
      # @return [number] status - The status code. Returns 201 if the feed has been successfully created.
      def create_feed(body)
        post("/feeds", body: body)
      end

      # Returns a list of feeds
      #
      # @return [Hash] list of feeds
      # @return [number] status
      #  - Returns 200 if successful
      def feeds
        get("/feeds")
      end

      # Execute a soft delete of a feed given a certain ID.
      #
      # @pathparams:
      # @param `feed_id` [String] The ID of the feed to delete.
      #
      # @return [Hash] The retrieved feed.
      # @return [number] status
      #  - Returns 204 if the feed has been deleted correctly.
      def delete_feed(feed_id)
        delete("/feeds/#{feed_id}")
      end
    end
  end
end
