# frozen_string_literal: true

require "tmpdir"

RSpec.describe SemanticRelease::Updaters::VersionRb do
  describe ".update" do
    let(:semver) { instance_double(SemanticRelease::Semver, :semver, to_s: "1.2.3") }

    around do |example|
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          example.run
        end
      end
    end

    before do
      allow(SemanticRelease::Semver).to receive(:load).and_return(semver)
      allow(Object).to receive(:`)
    end

    context "when version.rb is inside the lib directory" do
      before do
        FileUtils.mkdir_p("lib/foo")
        File.write("lib/version.rb", "module Foo\n" \
                                     "  VERSION = \"0.1.0\"\n" \
                                     "end\n")
      end

      it "updates the version" do
        described_class.update
        content = File.read("lib/version.rb")
        expect(content).to eq("module Foo\n" \
                              "  VERSION = \"1.2.3\"\n" \
                              "end\n")
      end

      it "adds the file to git" do
        described_class.update
        expect(Object).to have_received(:`).with("git add lib/version.rb")
      end
    end

    context "when version.rb is nested further inside the lib directory" do
      before do
        FileUtils.mkdir_p("lib/foo/bar")
        File.write("lib/foo/bar/version.rb", "module Foo::Bar\n" \
                                             "  VERSION = \"0.1.0\"\n" \
                                             "end\n")
      end

      it "updates the version" do
        described_class.update
        content = File.read("lib/foo/bar/version.rb")
        expect(content).to eq("module Foo::Bar\n" \
                              "  VERSION = \"1.2.3\"\n" \
                              "end\n")
      end

      it "adds the file to git" do
        described_class.update
        expect(Object).to have_received(:`).with("git add lib/foo/bar/version.rb")
      end
    end

    context "when there a multiple version.rb files" do
      before do
        FileUtils.mkdir_p("lib/foo/bar")
        File.write("lib/foo/version.rb", "module Foo\n" \
                                         "  VERSION = \"0.1.0\"\n" \
                                         "end\n")
        File.write("lib/foo/bar/version.rb", "module Foo::Bar\n" \
                                             "  VERSION = \"0.1.0\"\n" \
                                             "end\n")
      end

      it "doesn't change either file" do
        expect { described_class.update }.to not_change { File.read("lib/foo/version.rb") }
                                         .and(not_change { File.read("lib/foo/bar/version.rb") })
      end

      it "doesn't add either file to git" do
        described_class.update
        expect(Object).not_to have_received(:`)
      end
    end

    context "when there are no version.rb files" do
      it "doesn't add anything to git" do
        described_class.update
        expect(Object).not_to have_received(:`)
      end
    end
  end
end
