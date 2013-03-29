require_relative 'spec_helper'

# TODO AS: Replace this class with a mock
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

describe 'rescue_me' do

    before(:each) do
      @exception_counter = ExceptionCounter.new
    end

    it "runs an exception-free block of code once" do
      rescue_and_retry {
        @exception_counter.exception_free
      }
      @exception_counter.method_called_count.should == 1
    end

    it "attempts to run a block that raises an unexpected exception only once" do
      expect do
        rescue_and_retry(5, IOError) {
          @exception_counter.raise_zero_division_error
        }
      end.to raise_error ZeroDivisionError
      @exception_counter.method_called_count.should == 1
    end

    it "re-runs the block of code for exactly max_attempt number of times" do
      begin
        rescue_and_retry(3, ZeroDivisionError) {
          @exception_counter.raise_zero_division_error
        }
      rescue
      end
      @exception_counter.method_called_count.should == 3
    end

    it "re-runs the block of code for exactly a single time when specified" do
      @exception_counter = ExceptionCounter.new
      begin
        rescue_and_retry(1, ZeroDivisionError) {
          @exception_counter.raise_zero_division_error
        }
      rescue
      end
      @exception_counter.method_called_count.should == 1
    end

    it "does not re-run the block of code after it has run successfully" do
      expect do
        rescue_and_retry(5, Net::SMTPServerBusy) {
          @exception_counter.raise_smtp_exception_until_call(3)
        }
      end.to_not raise_error
      @exception_counter.method_called_count.should == 3
    end

end
