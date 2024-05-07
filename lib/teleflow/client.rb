# frozen_string_literal: true

require "teleflow/api/blueprints"
require "teleflow/api/changes"
require "teleflow/api/connection"
require "teleflow/api/environments"
require "teleflow/api/events"
require "teleflow/api/execution_details"
require "teleflow/api/feeds"
require "teleflow/api/inbound_parse"
require "teleflow/api/integrations"
require "teleflow/api/layouts"
require "teleflow/api/messages"
require "teleflow/api/notification_groups"
require "teleflow/api/notification_templates"
require "teleflow/api/notification"
require "teleflow/api/organizations"
require "teleflow/api/subscribers"
require "teleflow/api/tenants"
require "teleflow/api/topics"
require_relative "version"

module Teleflow
  class Client
    include HTTParty
    include Teleflow::Api::Blueprints
    include Teleflow::Api::Changes
    include Teleflow::Api::Connection
    include Teleflow::Api::Environments
    include Teleflow::Api::Events
    include Teleflow::Api::ExecutionDetails
    include Teleflow::Api::Feeds
    include Teleflow::Api::InboundParse
    include Teleflow::Api::Integrations
    include Teleflow::Api::Layouts
    include Teleflow::Api::Messages
    include Teleflow::Api::NotificationGroups
    include Teleflow::Api::NotificationTemplates
    include Teleflow::Api::Notification
    include Teleflow::Api::Organizations
    include Teleflow::Api::Subscribers
    include Teleflow::Api::Tenants
    include Teleflow::Api::Topics

    format :json

    attr_accessor :enable_retry, :max_retries, :initial_delay, :max_delay, :idempotency_key

    # @param `access_token` [String]
    # @param `idempotency_key` [String]
    # @param `enable_retry` [Boolean]
    # @param `retry_config` [Hash]
    #           - max_retries [Integer]
    #           - initial_delay [Integer]
    #           - max_delay [Integer]
    def initialize(access_token: nil, idempotency_key: nil, enable_retry: false, retry_config: {}, backend_url: "https://api-teleflow.khulnasoft.com/v1")
      raise ArgumentError, "Api Key cannot be blank or nil" if access_token.blank?

      @idempotency_key = idempotency_key.blank? ? UUID.new.generate : idempotency_key

      @enable_retry = enable_retry
      @access_token = access_token.to_s.strip
      @retry_attempts = 0

      retry_config = defaults_retry_config.merge(retry_config)
      @max_retries = retry_config[:max_retries]
      @initial_delay = retry_config[:initial_delay]
      @max_delay = retry_config[:max_delay]

      self.class.base_uri(backend_url)

      self.class.default_options.merge!(headers: { 
					"Authorization" => "ApiKey #{@access_token}",
					"User-Agent" => "teleflow/ruby/#{Teleflow::VERSION}" 
				}
			)

      # Configure the exponential backoff - specifying initial and maximal delays, default is 4s and 60s respectively
      if @enable_retry
        @retry_config = retry_config
        @backoff = ExponentialBackoff.new(@initial_delay, @max_delay)
      end
    rescue ArgumentError => e
      puts "Error initializing Teleflow client: #{e.message}"
    end

    private 

    # @retun [Hash]
    #   - max_retries [Integer]
    #   - initial_delay [Integer]
    #   - max_delay [Integer]
    def defaults_retry_config
      { max_retries: 1, initial_delay: 4, max_delay: 60 }
    end
  end
end
