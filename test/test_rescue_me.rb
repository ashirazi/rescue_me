require 'helper'

class TestRescueMe < Test::Unit::TestCase

  class ExceptionCounter

    require 'net/smtp'
    attr_reader :method_called_count

    def initialize
      @method_called_count = 0
    end

    def exception_free
      @method_called_count += 1
      "This method does not raise exceptions"
    end

    def raise_zero_division_error
      @method_called_count += 1
      12/0
    end

    # Will raise SMTPServerBusy the first x times this method is called,
    # after which this method does nothing.
    def raise_smtp_exception_until_call(times)
      @method_called_count += 1
      @smtp_exception_count = (@smtp_exception_count ||= 0) + 1
      raise Net::SMTPServerBusy if times > @smtp_exception_count
    end

  end # ExceptionCounter

  context "rescue_and_retry of code that might raise temporary exceptions" do
    setup do
      @exception_counter = ExceptionCounter.new
    end

    should "run an exception-free block of code once" do
      assert_nothing_raised do
        rescue_and_retry {
          @exception_counter.exception_free
        }
      end
      assert_equal 1, @exception_counter.method_called_count
    end

    should "attempt to run a block that raises an unexpected exception only once" do
      assert_raise(ZeroDivisionError) do
        rescue_and_retry(5, IOError) {
          @exception_counter.raise_zero_division_error
        }
      end
      assert_equal 1, @exception_counter.method_called_count
    end

    should "re-run the block of code for exactly max_attempt number of times" do
      assert_raise(ZeroDivisionError) do
        rescue_and_retry(3, ZeroDivisionError) {
          @exception_counter.raise_zero_division_error
        }
      end
      assert_equal 3, @exception_counter.method_called_count

      @exception_counter = ExceptionCounter.new

      assert_raise(ZeroDivisionError) do
        rescue_and_retry(1, ZeroDivisionError) {
          @exception_counter.raise_zero_division_error
        }
      end
      assert_equal 1, @exception_counter.method_called_count
    end

    should "not re-run the block of code after it has run successfully" do
      assert_nothing_raised do
        rescue_and_retry(5, Net::SMTPServerBusy) {
          @exception_counter.raise_smtp_exception_until_call(3)
        }
      end
      assert_equal 3, @exception_counter.method_called_count
    end

  end

end
