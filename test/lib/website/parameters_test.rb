require "test_helper"

describe Website::Parameters do

  describe "default attributes" do
    
    it "must have a base url" do
      params = Website::Parameters.new("lorem.ipsum.dolor", "/lorem")
      params.base_url.wont_be_nil
    end

    it "must have a current url" do
      params = Website::Parameters.new("lorem.ipsum.dolor", "/lorem")
      params.current_url.wont_be_nil
    end
  end

end