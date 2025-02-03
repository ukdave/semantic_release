# frozen_string_literal: true

require "tmpdir"

RSpec.describe SemanticRelease do
  it "has a version number" do
    expect(SemanticRelease::VERSION).not_to be_nil
  end

  describe ".init" do
    around do |example|
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          example.run
        end
      end
    end

    context "when the semver file already exists" do
      it "raises an error" do
        File.write(".semver", "some version info")
        expect { described_class.init }.to raise_error(SemanticRelease::Error, ".semver already exists")
      end
    end

    context "when the semver file does not exist" do
      it "creates the file" do
        expect { described_class.init }.to change { File.exist?(".semver") }.from(false).to(true)
      end
    end
  end
end
