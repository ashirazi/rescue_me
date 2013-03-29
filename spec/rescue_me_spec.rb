require_relative 'spec_helper'

class TestLogger # required because RSpec mocks have their own #warn
  def warn(msg); STDERR.puts msg; end
end

describe 'rescue_me' do

  let(:logger) { TestLogger.new }
  let(:test_class) { double "TestClass" }

  it "runs an exception-free block of code once" do
    test_class.should_receive(:sendmail).once
    rescue_and_retry { test_class.sendmail }
  end

  it "attempts to run a block that raises an unexpected exception only once" do
    test_class.stub(:sendmail).and_raise(NameError)
    test_class.should_receive(:sendmail).once
    expect {
      rescue_and_retry(4, IOError) { test_class.sendmail }
    }.to raise_error
  end

  it "re-runs the block of code for exactly max_attempt number of times" do
    test_class.stub(:sendmail).and_raise(IOError)
    test_class.should_receive(:sendmail).exactly(2).times
    expect {
      rescue_and_retry(2, IOError) { test_class.sendmail }
    }.to raise_error
  end

  it "re-runs the block of code for exactly a single time when specified" do
    test_class.stub(:sendmail).and_raise(IOError)
    test_class.should_receive(:sendmail).once
    expect {
      rescue_and_retry(1, IOError) { test_class.sendmail }
    }.to raise_error
  end

  it "does not re-run the block of code after it has run successfully" do
    test_class.stub(:sendmail) {
      @x ||= 0; @x += 1; raise IOError if @x < 3
    }
    test_class.should_receive(:sendmail).exactly(3).times
    expect {
      rescue_and_retry(5, IOError) { test_class.sendmail }
    }.to_not raise_error
  end

  it "names the enclosing method from which an exception arises" do
    test_class.stub(:sendmail).and_raise(IOError)
    test_class.stub(:logger).and_return(logger)
    logger.should_receive(:warn).with(/rescue_me_spec/)
    expect {
      rescue_and_retry(1, IOError) { test_class.sendmail }
    }.to raise_error
  end

end
