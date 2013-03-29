require "logger"
require "rescue_me/kernel"
require "rescue_me/logger"
require "rescue_me/version"

module RescueMe
  class << self
    def logger
      @logger ||= defined?(Rails) && Rails.respond_to?(:logger) ? Rails.logger : ::Logger.new($stdout)
    end
  end
end
