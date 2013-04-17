require "test_helper"

describe Website::Page do

  params = Website::Parameters.new("","","","")
  index = Website::Page.new(params)

  it "must have parameters" do
    index.params.wont_be_nil
  end

  it "params must be an instance of Website::Parameters"
end