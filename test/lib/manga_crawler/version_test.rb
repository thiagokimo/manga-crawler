require "test_helper"

describe MangaCrawler do
  it "must have a version" do
    version = MangaCrawler::VERSION
    version.wont_be_nil
  end
end