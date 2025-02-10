# frozen_string_literal: true

require "tmpdir"

RSpec.describe SemanticRelease::Updaters::Changelog do
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

    context "when there is a CHANGELOG.md file" do
      before do
        File.write("CHANGELOG.md", "* Some changes")
      end

      it "prepends the version" do
        described_class.update
        content = File.read("CHANGELOG.md")
        expect(content).to eq("## v1.2.3 (#{Time.now.strftime("%d %B %Y")})\n\n" \
                              "* Some changes")
      end

      it "adds the file to git" do
        described_class.update
        expect(Object).to have_received(:`).with("git add CHANGELOG.md")
      end
    end

    context "when there is a history.rdoc file" do
      before do
        File.write("history.rdoc", "* Some changes")
      end

      it "prepends the version" do
        described_class.update
        content = File.read("history.rdoc")
        expect(content).to eq("== v1.2.3 (#{Time.now.strftime("%d %B %Y")})\n\n" \
                              "* Some changes")
      end

      it "adds the file to git" do
        described_class.update
        expect(Object).to have_received(:`).with("git add history.rdoc")
      end
    end
  end
end
