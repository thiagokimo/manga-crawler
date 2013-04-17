require "test_helper"

describe Website::Parameters do

  describe "default attributes" do

    base_url = "lorem.ipsum.dolor"
    current_url = "/lorem"
    css_path = "#lorem"
    html_field = "src"
    params = Website::Parameters.new(base_url, current_url, css_path, html_field)
    
    it "must have a base url" do
      params.base_url.wont_be_nil
    end

    it "must have a current url" do
      params.current_url.wont_be_nil
    end

    it "must have a css path" do
      params.css_path.wont_be_nil
    end

    it "must have a html attribute" do
      params.html_field.wont_be_nil
    end
  end

end