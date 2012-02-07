module Kernel

  # Reattempts to run code passed in to this block if a temporary exception occurs
  # (e.g. Net::SMTPServerBusy), using an exponential back-off algorithm
  # (e.g. retry immediately, then after 1, 2, 4, 8, 16, 32... sec).
  #   max_attempts - the maximum number of attempts to make trying to run the
  #       block successfully before giving up
  #   temporary_exceptions - temporary exceptions that are to be caught in your
  #       code. If no exceptions are provided will capture all Exceptions. You are
  #       strongly encouraged to provide arguments that capture temporary
  #       exceptional conditions that are likely to work upon a retry.
  def rescue_and_retry(max_attempts=7, *temporary_exceptions)
    retry_interval = 2 # A good initial start value. Tweak as needed.
    temporary_exceptions << Exception if temporary_exceptions.empty?
    begin
      yield
    rescue *temporary_exceptions => e
      attempt = (attempt || 0) + 1
      RescueMe::Logger.warn(attempt, max_attempts, caller, e)

      raise(e) if attempt >= max_attempts

      # Retry immediately before exponential waits (1, 2, 4, 16, ... sec)
      sleep retry_interval**(attempt - 2) if attempt >= 2
      retry
    end
  end

end

module RescueMe
  require "logger"

  class << self
    def logger
      @logger ||= defined?(Rails) && Rails.respond_to?(:logger) ? Rails.logger : ::Logger.new($stdout)
    end
  end

  module Logger

    class << self
      def warn(attempt, max_attempts, kaller, exception)
        if RescueMe.logger && RescueMe.logger.respond_to?(:warn)
          RescueMe.logger.warn(rescued_message(attempt, max_attempts, kaller, exception))
        end
      end

      def rescued_message(attempt, max_attempts, kaller, exception)
        "rescue and retry (attempt #{attempt}/#{max_attempts}): " +
        "#{kaller.first}, <#{exception.class}: #{exception.message}>"
      end
    end

  end

end
