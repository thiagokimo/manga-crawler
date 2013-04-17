require "test_helper"

describe Website::Index do
  it "must have parameters" do

    params = Website::Parameters.new("","","","")
    index = Website::Index.new(params)
    
    index.params.wont_be_nil
  end
end