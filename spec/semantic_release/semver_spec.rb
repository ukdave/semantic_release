# frozen_string_literal: true

require "tempfile"

RSpec.describe SemanticRelease::Semver do
  describe ".load" do
    it "loads the version information from a file" do
      tf = Tempfile.new(".semver")
      tf.write('{"major":1,"minor":2,"patch":3}')
      tf.close

      semver = described_class.load(tf.path)
      expect(semver.to_s).to eq "1.2.3"
    end
  end

  describe "#save" do
    it "saves the version information to a file" do
      tf = Tempfile.new(".semver").tap(&:close)

      semver = described_class.new(major: 1, minor: 2, patch: 3)
      semver.save(tf.path)

      json = JSON.load_file(tf.path)
      expect(json).to eq({ "major" => 1, "minor" => 2, "patch" => 3 })
    end
  end

  describe "#increment" do
    subject(:semver) { described_class.new(major: 1, minor: 2, patch: 3) }

    describe "major part" do
      it "increments the major part and resets the minor and patch parts" do
        semver.increment(:major)
        expect(semver.to_s).to eq "2.0.0"
      end
    end

    describe "minor part" do
      it "increments the minor part and resets the patch part" do
        semver.increment(:minor)
        expect(semver.to_s).to eq "1.3.0"
      end
    end

    describe "patch part" do
      it "increments the patch part" do
        semver.increment(:patch)
        expect(semver.to_s).to eq "1.2.4"
      end
    end

    describe "invalid part" do
      it "raises an error" do
        expect { semver.increment(:foo) }.to raise_error "Bad term"
      end
    end
  end

  describe "#to_s" do
    it "returns a string representation of the version" do
      semver = described_class.new(major: 1, minor: 2, patch: 3)
      expect(semver.to_s).to eq "1.2.3"
    end
  end

  describe "#to_h" do
    it "returns a hash representaion of the version" do
      semver = described_class.new(major: 1, minor: 2, patch: 3)
      expect(semver.to_h).to eq({ major: 1, minor: 2, patch: 3 })
    end
  end

  describe "comparable" do
    it "equals another object with the same version" do
      v1 = described_class.new(major: 1, minor: 2, patch: 3)
      v2 = described_class.new(major: 1, minor: 2, patch: 3)
      expect(v1).to eq(v2)
    end

    it "does not equal another object with a different version" do
      v1 = described_class.new(major: 1, minor: 2, patch: 3)
      v2 = described_class.new(major: 3, minor: 2, patch: 1)
      expect(v1).not_to eq(v2)
    end

    # rubocop:disable RSpec/ExampleLength
    it "compares against another version" do
      semvers = [
        described_class.new(major: 0, minor: 1, patch: 0),
        described_class.new(major: 0, minor: 1, patch: 1),
        described_class.new(major: 0, minor: 2, patch: 0),
        described_class.new(major: 1, minor: 0, patch: 0)
      ]
      semvers.each_cons(2) do |v1, v2|
        expect(v1).to be < v2
      end
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
