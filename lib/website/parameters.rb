module Website
  class Parameters

    attr_reader :base_url

    def initialize(base_url)
      @base_url = base_url
    end
  end
end