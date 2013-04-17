module Website
  class Parameters

    attr_reader :base_url, :current_url

    def initialize(base_url, current_url)
      @base_url = base_url
      @current_url = current_url
    end
  end
end