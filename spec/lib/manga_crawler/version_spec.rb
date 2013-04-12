require "spec_helper"

describe "Version" do
  it "most have a version" do
    version = MangaCrawler::VERSION
    version.should_not be_empty
  end
end