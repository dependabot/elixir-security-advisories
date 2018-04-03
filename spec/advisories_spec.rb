require "rspec"
require "support/advisory_example"

describe "advisories" do
  Dir.glob(File.join(File.dirname(__FILE__), '../packages/*/*.yml')) do |path|
    include_examples 'Advisory', path
  end
end
