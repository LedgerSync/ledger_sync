# frozen_string_literal: true

def stubs_and_times
  @stubs_and_times ||= []
end

def stubs_and_times_reset
  @stubs_and_times = []
end

module WebMock
  module API
    # Overwrite the original stub_request method to enforce we explicitly say
    # how many times we expect a request to be called
    def stub_request(*args, times: 1)
      ret = WebMock::StubRegistry.instance
                                 .register_request_stub(WebMock::RequestStub.new(*args))
      stubs_and_times << [ret, times] unless times.nil?
      ret
    end
  end
end

RSpec.configure do |config|
  config.before { WebMock.reset! }
  config.after do
    stubs_and_times.each do |stub, times|
      expect(stub).to have_been_requested.times(times)
    end
    stubs_and_times_reset
  end
end
