require "test_helper"

describe Website::Page do

  params = Website::Parameters.new("","","","")
  page = Website::Page.new(params)

  it "must have parameters" do
    page.params.wont_be_nil
    lambda { Website::Page.new(nil) }.must_raise(RuntimeError)
  end

  it "params must be an instance of Website::Parameters" do
    lambda { Website::Page.new("invalid params") }.must_raise(RuntimeError)
    lambda { Website::Page.new(params) }.must_be_silent
  end
end