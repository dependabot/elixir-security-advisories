require "rspec"
require "support/advisory_example"

def advisories
  @advisories ||=
    begin
      dir = File.dirname(__FILE__)
      Dir.glob(File.join(dir, '../packages/*/*.yml')).reduce({}) do |hash, path|
        hash[path] = YAML.load_file(path)
        hash
      end
    end
end

def advisory_ids
  @advisory_ids ||= advisories.map { |_, a| a['id'] }
end

describe "advisories" do
  advisories.each do |path, advisory|
    include_examples 'Advisory', path, advisory

    it "uses a unique ID in #{path}" do
      expect(advisory_ids.count { |i| i == advisory['id'] }).to eq(1)
    end
  end
end
