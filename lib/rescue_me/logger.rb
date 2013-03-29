module RescueMe
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
