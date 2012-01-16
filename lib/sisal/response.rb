module Sisal
  class Response
    # Since we can't abstract all providers responses,
    # let's use params as a general purpose hash
    attr_accessor :status, :description, :params

    def initialize(success, status, description, params = {})
      @success, @status, @description, @params = success, status, description, params
    end

    # The value of @success must be set by the caller object,
    # usually the provider.
    def success?
      !!@success
    end
  end
end