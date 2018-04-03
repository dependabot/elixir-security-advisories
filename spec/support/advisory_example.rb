require "rspec"
require "yaml"
require_relative "./elixir_requirement"

shared_examples_for "Advisory" do |path|
  advisory = YAML.load_file(path)

  describe path do
    let(:filename) { File.basename(path).chomp(".yml") }

    describe "package" do
      subject(:package) { advisory['package'] }

      it { is_expected.to be_kind_of(String) }
      it "should be equal to filename (case-insensitive)" do
        expect(subject.downcase).to eq(package.downcase)
      end
    end

    describe "disclosure_date" do
      subject(:disclosure_date) { advisory["disclosure_date"] }

      it { is_expected.to be_kind_of(Date) }
      specify { expect(filename).to start_with(disclosure_date.to_s) }
    end

    describe "cve" do
      subject { advisory["cve"] }

      it "may be nil or a String" do
        expect(subject).to be_kind_of(String).or(be_nil)
      end
    end

    describe "link" do
      subject { advisory["link"] }

      it { is_expected.to be_kind_of(String) }
      it { is_expected.not_to be_empty }
    end

    describe "title" do
      subject { advisory["title"] }

      it { is_expected.to be_kind_of(String) }
      it { is_expected.not_to be_empty }
    end

    describe "description" do
      subject { advisory["description"] }

      it { is_expected.to be_kind_of(String) }
      it { is_expected.not_to be_empty }
    end

    describe "patched_versions" do
      subject { advisory["patched_versions"] }

      it "may be nil or an Array" do
        expect(subject).to be_kind_of(Array).or(be_nil)
      end

      it "assumes that future versions will be patched" do
        unaffected_versions = advisory['unaffected_versions'] || []
        patched_versions    = advisory['patched_versions'] || []

        versions = (unaffected_versions + patched_versions).sort_by do |v|
          Elixir::Version.new(v.match(/[0-9.]+\.\d+/)[0])
        end

        # If a package is unpatched this test makes no sense
        unless patched_versions.none?
          expect(versions.last.match(/^>=|^>/)).to be_truthy
        end
      end

      describe "each patched version" do
        if advisory["patched_versions"]
          advisory["patched_versions"].each do |version|
            describe version do
              subject { version.split(", ") }

              it "should contain valid Elixir version requirements" do
                expect { Elixir::Requirement.new(*subject) }.not_to raise_error
              end
            end
          end
        end
      end
    end

    describe "unaffected_versions" do
      subject { advisory["unaffected_versions"] }

      it "may be nil or an Array" do
        expect(subject).to be_kind_of(Array).or(be_nil)
      end

      case advisory["unaffected_versions"]
      when Array
        advisory["unaffected_versions"].each do |version|
          describe version do
            subject { version.split(", ") }

            it "should contain valid Elixir version requirements" do
              expect { Elixir::Requirement.new(*subject) }.not_to raise_error
            end
          end
        end
      end
    end
  end
end
