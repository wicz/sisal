module Sisal
  class Response
    # Since we can't abstract all providers responses,
    # let's use params as a general purpose hash
    attr_accessor :success, :code, :params

    def initialize(success, code, params = {})
      @success, @code, @params = success, code, params
    end

    # The value of @success must be set by the caller object,
    # usually the provider.
    def success?
      @success == true
    end
  end
end