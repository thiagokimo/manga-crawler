module Website
  class Parameters

    attr_reader :base_url, :current_url, :css_path

    def initialize(base_url, current_url, css_path)
      @base_url = base_url
      @current_url = current_url
      @css_path = css_path
    end
  end
end