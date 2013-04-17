require "test_helper"

describe Website::Parameters do

  describe "default attributes" do
    
    it "must have a base url" do
      params = Website::Parameters.new("lorem.ipsum.dolor")
      params.base_url.wont_be_nil
    end

  end

end