module Website
  class Parameters

    attr_reader :base_url, :current_url, :css_path, :html_field

    def initialize(base_url, current_url, css_path, html_field)
      @base_url = base_url
      @current_url = current_url
      @css_path = css_path
      @html_field = html_field
    end
  end
end